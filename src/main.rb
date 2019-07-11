require_relative 'qiita_scraper'

puts QiitaScraper.run.map(&:description)
