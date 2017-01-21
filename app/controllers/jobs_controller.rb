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
  	@job = Job.create(params.require(:job).permit(:title, :location, :description, :company_id, :category, :featured))

  	redirect_to @job
  end
end
