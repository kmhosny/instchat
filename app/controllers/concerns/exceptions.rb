module Exceptions
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json:{ error: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::NotNullViolation do |e|
      render json:{ error: e.message }, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { error: e.message }, status: :bad_request
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: { error: e.message }, status: :bad_request
    end
  end
end
