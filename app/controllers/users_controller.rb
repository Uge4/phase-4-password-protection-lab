class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    before_action :authorize
    skip_before_action :authorize, only: [:create]
    wrap_parameters :user

    def create
        user = User.create(user_params)
            if user.valid?
                session[:user_id] = user.id 
                render json: user, status: :created
            else  
                render json: { errors: user.errors.full_messages}, status: :unprocessable_entity
            end
    end

    def show
        user = User.find_by(id: session[:user_id])
        session[:user_id] = user.id 
        render json: user, status: :created
    end
    
    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
        
    end

    def render_not_found_response
        render json: { error: invalid.record.errors }, status: unprocessable_entity
    end

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id 
    end

end
