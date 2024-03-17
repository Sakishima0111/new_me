require 'line/bot'

class PushLineJob < ApplicationJob
  queue_as :default

  def perform(*args)
    limit_three_days = Datetime.today..Time.now.end_of_day + (3.days)
    users = User.all
    users.each do |user|
      if user.line_alert == true
        limit_goals =  Goal.where(user_id: user.id).where(deadline: limit_three_days)
        if limit_goals != []
          titles = limit_goals.map {|goal| goal.title } 
          message = {
                type: 'text',
                text: "あと3日で#{goals.join(',')}の期限がきます。目標の期限が過ぎたら進捗ステータスを『達成』に変更し、振り返りを行いましょう。"
              }
          response = line_client.push_message(user.uid, message)
          logger.info "PushLineSuccess"
        end
      end
    end
  end

  private

  def line_client
    Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end