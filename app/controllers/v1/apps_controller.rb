class V1::AppsController < ApplicationController
  before_action :set_app, only: [:show, :update, :destroy]

  def index
    page = params[:page] || 1
    @apps = App.paginate(page: page)
    render json: @apps
  end

  def create
    name = params.require(:name)
    @app = App.create!(name: name)
    render json: @app, status: :created
  end

  def show
    render json: @app
  end

  def update
    name = params.require(:name)
    @app.update!(name: name)
    head :no_content
  end

  def destroy
    @app.destroy
    head :no_content
  end

  private
  def set_app
    @app = App.find_by!(uid:  params[:id])
  end
end
