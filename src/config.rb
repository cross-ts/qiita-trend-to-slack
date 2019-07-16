#
# Config and Const
#
module Config
  SLACK_API_TOKEN = ENV.fetch('SLACK_API_TOKEN')
  NOTIFY_CHANNEL = ENV.fetch('NOTIFY_CHANNEL', '#qiita')
  HTTPS_PORT = 443
  QIITA_URL = 'https://qiita.com'
  QIITA_ICON = 'https://cdn.qiita.com/assets/favicons/public/apple-touch-icon-f9a6afad761ec2306e10db2736187c8b.png'
  GREEN = "#36a64f"
end
