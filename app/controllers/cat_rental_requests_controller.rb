class CatRentalRequestsController < ApplicationController
  def create
    CatRentalRequest.create(params[:cat_rental_request])
    index
  end

  def index
    @rentals = CatRentalRequest.all
    render :index
  end

  def new
    @cats = Cat.select("id, name").to_a
    render :new
  end

  def approve
    p "HERE"
    CatRentalRequest.find(params[:id]).approve
    redirect_to :back
  end

end
