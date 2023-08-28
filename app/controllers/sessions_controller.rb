class SessionsController < ApplicationController

    # def create
    #     user = User.find_by(username: params[:username])
    #     session[:user_id] = user.id
    #     render json: user
    # end

    def create
      user = User.find_by(username: params[:username])
      if user.present? && user.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { error: "Invalid username or password" }, status: :unauthorized
        end
        # byebug
    end

    def destroy
        session.delete :user_id
        head :no_content
    end
    
end
