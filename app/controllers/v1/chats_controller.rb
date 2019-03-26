class V1::ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]
  before_action :set_app, only: :create

  def index
    page = params[:page] || 1
    @chats = Chat.paginate(page: page)
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
    @app = App.find_by!(uid: params[:app_id], )
    @chat = Chat.find_by!(id:  params[:id], app_id: @app.id)
  end

  def set_app
    @app = App.find_by!(uid: params[:app_id])
  end
end
