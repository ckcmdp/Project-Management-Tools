class CommentsController < ApplicationController
    before_action :authorized, only: [:create]

    def create
        @user_name = current_user.firstname
        @feature = Feature.find(params[:feature_id])
        @comment = @feature.comments.create(comments_params)
        respond_to do |format|
            format.html { redirect_to feature_path(@feature) }
            format.js
        end    
        
        
    end  
    
    
    private
    def comments_params
        params.require(:comment).permit(:comment, :name)
    end    
end



