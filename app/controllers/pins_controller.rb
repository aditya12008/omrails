class PinsController < ApplicationController
  before_filter :set_pin, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index]

  respond_to :html

  def index
    #if we want only our pins too see then
    # @pins = current_user.pins.all
    @pins = Pin.order("created_at desc").page(params[:page]).per_page(20)
    respond_with(@pins)
  end

  def show
    respond_with(@pin)
  end

  def new
    @pin = current_user.pins.new
    respond_with(@pin)
  end

  def edit
    @pin = current_user.pins.find(params[:id])
  end

  def create
    @pin = current_user.pins.new(params[:pin])
    @pin.save
    respond_with(@pin)
  end

  def update
    @pin = current_user.pins.find(params[:id])
    @pin.update_attributes(params[:pin])
    respond_with(@pin)
  end

  def destroy
    @pin = current_user.pins.find(params[:id])
    @pin.destroy
    respond_with(@pin)
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end
end
