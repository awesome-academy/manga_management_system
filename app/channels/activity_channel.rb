class ActivityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "activity_channel"
  end

  def unsubscribed
    stop_all_stream
  end
end
