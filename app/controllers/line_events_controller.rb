class LineEventsController < ApplicationController
  require 'line/bot'

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
  
  def recieve
    body = request.body.read
    events = client.parse_events_from(body)
    events.each { |event|
      userId = event['source']['userId']  #userId取得
      p 'UserID: ' + userId # UserIdを確認
    end
  end
  
end
