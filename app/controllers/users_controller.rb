class UsersController < ApplicationController
  before_filter :authenticate,   :only => [:show, :edit, :update, :destroy]
  before_filter :correct_user,   :only => [:show, :edit, :update ]
  before_filter :check_priority, :only => :destroy

  # GET /users
  # GET /users.xml
  def index
    @title = :List_of_Users
    #@users = User.all
    @users = User.paginate(:page => params[:page])

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @users }
    #end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = :Show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = :Sign_Up
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = :Edit_Profile
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
		  sign_in @user
        format.html { redirect_to(@user, :notice => 'Your account has been created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        @title = :Sign_Up
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Your Profile Updated.') }
        format.xml  { head :ok }
      else
        @title = :Edit_Profile
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  private
    def authenticate
      deny_access unless signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
      	flash[:notice] = "You don't have the priviledge! Please sign in with right account"
         redirect_to(home_path)
         #redirect_back_or(home_path) #cause the loop! never get to require uri
      end
    end
    def check_priority
      if !current_user.admin?
         flash[:notice] = "You don't have the right to delete"
         redirect_to(users_path)
      end
    end
end
