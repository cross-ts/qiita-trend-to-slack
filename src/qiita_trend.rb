#
# Qiitaのトレンド記事
#
class QiitaTrend
  attr_accessor :title, :author, :uuid, :rank

  def initialize(json, rank:)
    self.rank = rank
    self.title = json['node']['title']
    self.author = json['node']['author']['urlName']
    self.uuid = json['node']['uuid']
  end

  def url
    "https://qiita.com/#{author}/items/#{uuid}"
  end

  def description
    <<-DESCRIPTION
-------------------------------------------
  rank : #{rank}
  title: #{title}
  url  : #{url}
-------------------------------------------
    DESCRIPTION
  end
end
