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
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each { |event|
      user_id = event['source']['userId']
      user = User.where(uid: user_id)[0]
      if event.message['text'].include?("お買い物リスト")
        message = shopping_list(send_limit_item(user))
      elsif event.message['text'].include?("自動購入機能テスト")
        message = test_selenium(user)
      end

      case event
      # メッセージが送信された場合
      when Line::Bot::Event::Message
        case event.type
        # メッセージが送られて来た場合
        when Line::Bot::Event::MessageType::Text
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

  private

  def send_deadline_notification
    goals = Goal.where("deadline <= ?", 3.days.from_now)
    goals.each do |goal|
      message = "目標のタイトルの期限が近づいています。期限は#{goal.deadline.strftime('%Y年%m月%d日')}です。"
      # LINE通知の処理を追加する
      # メッセージの送信先はgoalの関連するユーザーになります
    end
  end

end

