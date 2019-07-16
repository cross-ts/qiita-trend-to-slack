#
# Slackに通知するクラス
#
require 'singleton'
require 'slack-ruby-client'

require_relative 'config'

class Notifier
  include Singleton

  def initialize
    Slack.configure { |config| config.token = Config::SLACK_API_TOKEN }
    client.auth_test
  end

  def notify!(trends)
    post(attachments: trends.map(&:to_slack_attachment), thread_ts: thread)
  end

  private

  def post(message)
    client.chat_postMessage(message.merge(channel: Config::NOTIFY_CHANNEL))
  end

  def thread
    @thread ||= post(text: "*【Qiita Trend】* at *#{now}*").ts
  end

  def now
    Time.now.strftime('%Y/%m/%d %H:%M')
  end

  def client
    @client ||= Slack::Web::Client.new
  end
end
