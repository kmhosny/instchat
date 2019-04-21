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
    #Redis.current.lpush 'pending_messages', {body: body, chat_id: @chat.id}.to_json
    ActionCable.server.broadcast "#{params[:app_id]}_chat_#{params[:chat_id]}",
                                   body:  body
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
    set_chat
    @message = Message.find_by!(mid:  params[:id], chat_id: @chat.id)
  end

  def set_app
    @app = App.find(params[:app_id])
  end

  def set_chat
    @chat = Chat.find_by!(cid: params[:chat_id], app_id: params[:app_id])
  end
end
