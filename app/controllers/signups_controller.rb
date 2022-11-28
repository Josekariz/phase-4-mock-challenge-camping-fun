class SignupsController < ApplicationController
  #rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def create
    sign =Signup.create!(signup_params)
    render json: sign.activity, status: :created 

  rescue ActiveRecord::RecordInvalid => e
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end
  private
  def signup_params
    params.permit(:time, :camper_id, :activity_id)
  end
  # def invalid(e)
  #   render json: {error: e}, status: :unprocessable_entity
  # end
end
