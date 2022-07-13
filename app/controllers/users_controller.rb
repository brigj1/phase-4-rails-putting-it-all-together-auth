class UsersController < ApplicationController
    wrap_parameters format: []
    skip_before_action :authenticate_user, only: [:create]

    # POST '/signup'
    def create
        user = User.create!(user_params)
          session[:user_id] = user.id
          render json: user, status: :created
        # if user.valid?
        # else
        #   render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        # end
    end

      # GET '/me'
  def show
    #if current_user
      render json: current_user, status: :ok
    # else
    #   render json: { errors: "No active session" }, status: :unauthorized
    # end
  end
    
    private
    
    def user_params
        # params.permit(:username, :password_digest, :image_url, :bio, :password, :password_confirmation)
        params.permit(:username, :image_url, :bio, :password, :password_confirmation)
    end
end
