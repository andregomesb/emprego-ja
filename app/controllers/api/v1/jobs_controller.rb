module Api
  class V1::JobsController < ApplicationController

    before_action :set_job, only: [:show, :update, :destroy]

    def index
      @jobs = Job.all
      render json: @jobs
    end

    def show
      render json: @job
    end

    def create
      @job = Job.new(job_params)
      if @job.save
        render json: @job, status: 201
      else
        render json: { errors: @job.errors }, status: 422
      end
    end

    def update
      if @job.update(job_params)
        head :no_content
      else
        render json: { errors: @job.errors }, status: 422
      end
    end

    def destroy
      @job.destroy
      head :no_content
    end

    private
    def job_params
      params.require(:job).permit(:title, :location, :description, :company_id, :category_id, :featured)
    end

    def set_job
      @job = Job.find(params[:id])
    end
end
end
