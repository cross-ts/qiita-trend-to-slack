#
# Qiitaのトレンド記事
#
require 'time'
require_relative 'config'

class QiitaTrend
  attr_reader :rank

  def initialize(json, rank:)
    @json = json
    @rank = rank
  end

  def title
    json.dig('node', 'title')
  end

  def author_name
    json.dig('node', 'author', 'urlName')
  end

  def author_icon
    json.dig('node', 'author', 'profileImageUrl')
  end

  def uuid
    json.dig('node', 'uuid')
  end

  def created_at
    Time.parse(json.dig('node', 'createdAt'))
  end

  def url
    "https://qiita.com/#{author_name}/items/#{uuid}"
  end

  def to_slack_attachment
    {
      color: Config::GREEN,
      author_name: author_name,
      author_icon: author_icon,
      title: title,
      title_link: url,
      footer: 'Qiita',
      footer_icon: Config::QIITA_ICON,
      ts: created_at.to_i,
    }
  end

  private

  def json
    @json
  end
end
