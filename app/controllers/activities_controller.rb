class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    def index
       activity = Activity.all
       render json: activity, status: :ok
    end

    def destroy
        activity = Activity.find(params[:id])
        if activity
            activity.signups.destroy
            activity.destroy
            head :no_content
        else 
            not_found
        end
    end

    private

    def not_found
        render json: {error: "Activity not found" }, status: :not_found
    end
end
