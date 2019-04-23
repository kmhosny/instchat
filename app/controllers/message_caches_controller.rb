class MessageCachesController < ApplicationController
  before_action :set_message_cach, only: [:show, :update, :destroy]

  # GET /message_caches
  def index
    @message_caches = MessageCache.all

    render json: @message_caches
  end

  # GET /message_caches/1
  def show
    render json: @message_cach
  end

  # POST /message_caches
  def create
    @message_cach = MessageCache.new(message_cach_params)

    if @message_cach.save
      render json: @message_cach, status: :created, location: @message_cach
    else
      render json: @message_cach.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /message_caches/1
  def update
    if @message_cach.update(message_cach_params)
      render json: @message_cach
    else
      render json: @message_cach.errors, status: :unprocessable_entity
    end
  end

  # DELETE /message_caches/1
  def destroy
    @message_cach.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message_cach
      @message_cach = MessageCache.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_cach_params
      params.require(:message_cach).permit(:body, :chat_id, :app_id)
    end
end
