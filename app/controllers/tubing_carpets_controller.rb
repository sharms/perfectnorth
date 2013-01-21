class TubingCarpetsController < ApplicationController
  def index
    @tubing_carpets = TubingCarpet.where(:created_at => (DateTime.now.beginning_of_day.utc .. Time.now.utc))
    respond_to do |format|
      format.json { render json: @tubing_carpets }
    end
  end

  def show
    @tubing_carpet = TubingCarpet.find(params[:id])
    respond_to do |format|
      format.json { render json: @tubing_carpet }
    end
  end
end
