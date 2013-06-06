class CatsController < ApplicationController
  before_filter :require_login

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @rentals = CatRentalRequest.where("cat_id = ?", params[:id]).order("begin_date")
    render :show
  end

  def new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def create
    params[:cat][:age] = params[:cat][:age].to_i
    Cat.create(params[:cat])
    index
  end

  def update
    params[:cat][:age] = params[:cat][:age].to_i
    Cat.find(params[:id]).update_attributes(params[:cat])
    redirect_to '/cats'
  end

  def destroy
  end
end
