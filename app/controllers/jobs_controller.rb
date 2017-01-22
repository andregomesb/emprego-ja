class JobsController < ApplicationController

  before_action :set_job, only: [:show, :edit, :update]
  before_action :set_collection, only: [:index, :new, :edit]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job, notice: t(".success")
    else
      set_collection
      flash.now[:alert] = t(".error")
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: t(".success")
    else
      set_collection
      flash.now[:alert] = t(".error")
      render :edit
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :location, :description, :company_id, :category_id, :featured)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def set_collection
    @categories = Category.all
    @companies = Company.all
  end
end
