class NewsController < ApplicationController
  def index
    @news = News.where(:created_at => (DateTime.now.at_beginning_of_day.utc .. Time.now.utc))
    respond_to do |format|
      format.json { render json: @news }
    end
  end

  def show
    @news = News.find(params[:id])
    respond_to do |format|
      format.json { render json: @news }
    end
  end
end
