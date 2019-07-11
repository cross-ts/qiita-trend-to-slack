require 'net/http'
require 'nokogiri'
require 'json'

require_relative 'qiita_trend'

#
# Qiitaのdailyトレンドをスクレイピングするクラス
#
class QiitaScraper
  QIITA_URL = 'https://qiita.com'
  HTTPS_PORT = 443

  class << self
    def run
      new.run
    end
  end

  def initialize
  end

  def run
    json.dig('trend', 'edges').map.with_index(1) do |trend, rank|
      QiitaTrend.new(trend, rank: rank)
    end
  end

  private

  def uri
    URI.parse(QIITA_URL)
  end

  def response
    http = Net::HTTP.new(uri.host, HTTPS_PORT)
    http.use_ssl = true
    http.get('/')
  end

  def document
    Nokogiri::HTML.parse(response.body)
  end

  def json
    JSON.parse(document.css('.p-home_main div')[0].attribute('data-hyperapp-props'))
  end
end
