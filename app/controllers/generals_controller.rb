class GeneralsController < ApplicationController
  def index
    @general = General.where(:created_at => (DateTime.now.at_beginning_of_day.utc .. Time.now.utc)).first
    respond_to do |format|
      format.json { render json: @general }
    end
  end

  def show
    @general = General.find(params[:id])
    respond_to do |format|
      format.json { render json: @general }
    end
  end
end
