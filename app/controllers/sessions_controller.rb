class SessionsController < ApplicationController
    wrap_parameters format: []
    skip_before_action :authenticate_user, only: [:create]

    # POST '/login'
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :ok
        else
          render json: { errors: ['Invalid credentials'] }, status: :unauthorized
        end
    end
end
