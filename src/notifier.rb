#
# Slackに通知するクラス
#
require 'singleton'
require 'slack-ruby-client'

class Notifier
  include Singleton

  NOTIFY_CHANNEL = '#qiita'

  def initialize
    raise "Missing ENV['SLACK_API_TOKEN']" unless ENV['SLACK_API_TOKEN']
    Slack.configure { |config| config.token = ENV['SLACK_API_TOKEN'] }
    client.auth_test
  end

  def notify!(trends)
    post(attachments: trends.map(&:to_slack_attachment), thread_ts: thread)
  end

  private

  def post(message)
    client.chat_postMessage(message.merge(channel: NOTIFY_CHANNEL))
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
