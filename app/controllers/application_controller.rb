class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ArgumentError, with: :handle_argument_error

  private

  def record_not_found(exception)
    render json: { errors: exception.message }, status: :not_found
  end

  def handle_argument_error(exception)
    render json: { errors: [exception.message] }, status: :unprocessable_entity
  end
end