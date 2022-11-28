class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_camper_not_found
#rescue_from ActiveRecord::RecordInvalid, with: :invalid
  def index
    campers =Camper.all
    render json: campers, status: :ok
  end

  def show
    camper=find_camper
    render json: camper, serializer: CamperActivitySerializer, status: :ok 
  end

  def create
    camper=Camper.create!(camper_params)
    render json: camper, status: :created     
  rescue ActiveRecord::RecordInvalid => e
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end

  private 
  def find_camper
    Camper.find(params[:id])
  end
    def render_camper_not_found
    render json: {error: 'Camper not found'} , status: :not_found
    end

    def camper_params
      params.permit(:name, :age)
    end
    # def invalid(e)
    #   render json: {error: e}, status: :unprocessable_entity
    # end
end
