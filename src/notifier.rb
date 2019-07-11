#
# Slackに通知するクラス
#
require 'singleton'
require 'slack-ruby-client'

class Notifier
  include Singleton

  NOTIFY_CHANNEL = '#qiita'

  def initialize
    Slack.configure { |config| config.token = ENV['SLACK_API_TOKEN'] }
    client.auth_test
  end

  def send(trend)
    client.chat_postMessage(
      channel: NOTIFY_CHANNEL,
      attachments: [trend.to_slack_attachment],
    )
  end

  private

  def client
    @client ||= Slack::Web::Client.new
  end
end
