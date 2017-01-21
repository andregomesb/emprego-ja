class JobsController < ApplicationController

  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @companies = Company.all
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job
    else
      @companies = Company.all
      flash[:notice] = t(".error")
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :location, :description, :company_id, :category, :featured)
  end
end
