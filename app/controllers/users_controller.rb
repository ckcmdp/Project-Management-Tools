class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create, :callback]
    before_action :get_user, only: [:show, :edit, :update]
     
    def get_user
        @user = User.find(params[:id])
    end    
    
    def new
        @user = User.new
    end

    def callback
        # Access the authentication hash for omniauth
        data = request.env['omniauth.auth']
        # Temporary for testing!
        create data
        
        redirect_to root_url
    end
    
  
    def create(data)
        @user = User.new(user_params)
        if @user.save
            UserMailer.delay.welcome_email(user: @user)
            session[:user_id] = @user.id
            redirect_to user_path(@user), success: "Welcome to the project management app !!!"
        else
            redirect_to new_user_path, danger: "Please fill all the field correctly with an unique EmailId and password with minimum 8 charecter and please put a profile picture"
        end 
    end    

    
    def createproject
        @user = current_user
        @user_id = current_user.id
    end  

    def show
    end
    
    def edit 
    end

    def update
        if @user.update(user_params)
            redirect_to @user,success: "Informations are updated"
        else
            render 'edit',danger: "Please fill all the Column"
        end        
    end 
    
    def destroy
        @user = User.find(params[:id])
        @user.delete
        UserMailer.with(user: @user).delete_profile.deliver
        redirect_to welcome_path, success: "Your profile is deleted and a confirmation mail is sent. "
    end
    
    private 
    def user_params
        params.require(:user).permit(:username, :image, :password, :firstname, :lastname, :gender, :reset_digest, :reset_sent_at)
    end  

end
