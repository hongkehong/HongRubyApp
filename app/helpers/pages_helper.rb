module PagesHelper

 def thelp
   tbase = "HAHA";
	if @title.nil?
	  tbase
   else
     "#{tbase} | #{@title}"
	end
 end
end
