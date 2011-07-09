require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation 
  #things submitted
  has_many :microposts, :dependent => :destroy
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed

  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  validates_presence_of :name, :email
  validates_length_of   :name, :maximum => 50
  validates_format_of   :email, :with => EmailRegex
  validates_length_of :name, :maximum => 50
  validates_uniqueness_of :email, :case_sensitive => false

  validates_confirmation_of :password
  validates_presence_of :password
  validates_length_of   :password, :within => 6..40
  
  before_save :encrypt_password
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    encrypted_password == encrypt(submitted_password)

  end

  def self.authenticate(email, submitted_password)
    #self is class method here, not the same as before - instance.var
    user = find_by_email(email)
    #class method search user database!
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end

  def feed
    #Micropost.all(:conditions => ["user_id = ?", id])
    # == this.microposts or self.microposts or just mircroposts
    # because the "has_many", make a_user.microposts methods to get all microposts with user_id = a.user.id!
    ###########
    ###########
    Micropost.from_users_followed_by(self)
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
   
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end


  private
    def encrypt_password
	 	#self.salt = make_salt
      #self.encrypted_password = encrypt(password)
      unless password.nil?
        self.salt = make_salt
        self.encrypted_password = encrypt(password)
      end
    end
    def encrypt(string)
      secure_hash("#{salt}#{string}") 
		#either make salt first time for the user or get if from users_db
    end
	 def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
