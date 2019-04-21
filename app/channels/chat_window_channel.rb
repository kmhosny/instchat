class ChatWindowChannel < ApplicationCable::Channel
  def subscribed
     stream_from "#{params[:app_id]}_chat_#{params[:chat_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
