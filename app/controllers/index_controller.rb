class IndexController < ApplicationController
   #before_filter :authenticate_user!
    
    def index
        
    end
    
    def mailing
        if (user_session == nil)
           redirect_to 'http://mail-service-0803-yoohoogun114.c9.io/users/sign_in' 
        end
    end
    
    
    def email_sender
        title = params[:mail_title]
        to = params[:mail_to]
        content = params[:mail_content]
        from = params[:mail_from]
        cc = params[:mail_cc]
        filepara = params[:mail_file]
        filesender = FileSender.new
        filesender.file_names = params[:mail_file]
        filesender.save
        fa = FileSender.find_by(file_names: @original_filename)
        Anycall.welcome_email(title, content , to, from, cc , filepara).deliver_now
        redirect_to 'http://mail-service-0803-yoohoogun114.c9.io/index/mailing'
    end
    
    def create
      @user = User.create( user_params )
    end
    
    private
    
    # Use strong_parameters for attribute whitelisting
    # Be sure to update your create() and update() controller methods.
    
    def user_params
      params.require(:user).permit(:avatar)
    end
    
end
