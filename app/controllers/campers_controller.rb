class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    def index
        campers = Camper.all
        render json: campers, status: :ok
    end

    def show 
        camper = Camper.find(params[:id])
        if camper
            render json: camper, include: :activities, status: :ok
        else
            not_found
        end
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper , status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def not_found
        render json: {error: 'Camper not found'}, status: :not_found
    end
end
