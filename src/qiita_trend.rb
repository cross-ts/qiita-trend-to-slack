#
# Qiitaのトレンド記事
#
require 'time'

class QiitaTrend
  attr_reader :rank

  QIITA_ICON = 'https://cdn.qiita.com/assets/favicons/public/apple-touch-icon-f9a6afad761ec2306e10db2736187c8b.png'
  GREEN = "#36a64f"

  def initialize(json, rank:)
    @json = json
    @rank = rank
  end

  def title
    json['node']['title']
  end

  def author_name
    json['node']['author']['urlName']
  end

  def author_icon
    json['node']['author']['profileImageUrl']
  end

  def uuid
    json['node']['uuid']
  end

  def created_at
    Time.parse(json['node']['createdAt'])
  end

  def url
    "https://qiita.com/#{author_name}/items/#{uuid}"
  end

  def to_slack_attachment
    {
      color: GREEN,
      author_name: author_name,
      author_icon: author_icon,
      title: title,
      title_link: url,
      footer: 'Qiita',
      footer_icon: QIITA_ICON,
      ts: created_at.to_i,
    }
  end

  private

  def json
    @json
  end
end
