class V1::ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]
  before_action :set_app, only: :create

  def index
    page = params[:page] || 1
    @chats = Chat.where(app_id: params[:app_id]).paginate(page: page)
    render json: @chats
  end

  def create
    @chat = @app.chats.create!
    render json: @chat, status: :created
  end

  def show
    render json: @chat
  end

  def update
    head :no_content
  end

  def destroy
    @chat.destroy
    head :no_content
  end

  private
  def set_chat
    @chat = Chat.find_by!(cid:  params[:id], app_id: params[:app_id])
  end

  def set_app
    @app = App.find(params[:app_id])
  end
end
