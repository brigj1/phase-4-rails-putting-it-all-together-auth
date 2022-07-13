class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_validation_errors
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action :authenticate_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def render_validation_errors(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
  
  def render_not_found(e)
    byebug
    render json: { errors: [e.message] }, status: :not_found
  end

  def authenticate_user
    return if current_user  # i.e. no problems to report
    render json: { errors: ["You must be logged in to do that."] }, status: :unauthorized
  end

end
