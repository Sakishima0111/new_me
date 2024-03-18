require 'line/bot'

class LinebotController < ApplicationController
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    send_deadline_notification
    head :ok
  end

  private

  def send_deadline_notification
    goals = Goal.where("deadline <= ?", 3.days.from_now)
    goals.each do |goal|
      message = "#{goal.title}の期限が近づいています。期限は#{goal.deadline.strftime('%Y年%m月%d日')}です。"
      # LINE通知の処理を追加する
      # メッセージの送信先はgoalの関連するユーザーになります
    end
  end

end

