#
# Qiitaのトレンド記事
#
class QiitaTrend
  attr_accessor :title, :author, :uuid, :rank

  QIITA_ICON = 'https://cdn.qiita.com/assets/favicons/public/apple-touch-icon-f9a6afad761ec2306e10db2736187c8b.png'
  GREEN = "#36a64f"

  def initialize(json, rank:)
    self.rank = rank
    self.title = json['node']['title']
    self.author = json['node']['author']['urlName']
    self.uuid = json['node']['uuid']
  end

  def url
    "https://qiita.com/#{author}/items/#{uuid}"
  end

  def to_slack_attachment
    {
      color: GREEN,
      author_name: author,
      author_icon: QIITA_ICON,
      title: title,
      title_link: url,
      footer_icon: QIITA_ICON,
      ts: 1,
    }
  end
end
