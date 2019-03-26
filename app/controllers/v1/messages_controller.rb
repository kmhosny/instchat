class V1::MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :set_app, :set_chat, only: :create

  def index
    page = params[:page] || 1
    keyword = params[:keyword] || '*'
    @messages = Message.search(keyword, where:{ chat_id: params[:chat_id], app_id: params[:app_id] }, fields: [body: :text_middle], load: false, page: params[:page]).map{|m| {body: m[:body]}}
    render json: @messages
  end

  def create
    body = params.require(:body)
    Redis.current.lpush 'pending_messages', {body: body, chat_id: @chat.id[0], app_id: @chat.id[1]}.to_json
    render json: {body: body}, status: :created
  end

  def show
    render json: @message
  end

  def update
    head :no_content
  end

  def destroy
    @message.destroy
    head :no_content
  end

  private
  def set_message
    @message = Message.find_by!(id:  params[:id], chat_id: params[:chat_id], app_id: params[:app_id])
  end

  def set_app
    @app = App.find(params[:app_id])
  end

  def set_chat
    @chat = Chat.find_by!(id: params[:chat_id], app_id: params[:app_id])
  end
end
