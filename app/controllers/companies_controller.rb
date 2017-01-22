class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update]

  def show
    @company = Company.find(params[:id])
  end
  def new
    @company = Company.new
  end

  def create
    @company = Company.new company_params
    if @company.save
      redirect_to @company, notice: t(".success")
    else
      flash.now[:alert] = t(".error")
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: t(".success")
    else
      flash.now[:alert] = t(".error")
      render :edit
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :location, :mail, :phone)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
