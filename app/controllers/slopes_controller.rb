class SlopesController < ApplicationController
  def index
    @slopes = Slope.where(:created_at => (DateTime.now.at_beginning_of_day.utc .. Time.now.utc))
    respond_to do |format|
      format.json { render json: @slopes }
    end
  end

  def show
    @slope = Slope.find(params[:id])
    respond_to do |format|
      format.json { render json: @slope }
    end
  end
end
