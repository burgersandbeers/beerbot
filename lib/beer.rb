# frozen_string_literal: true

class Beer
  URL = ENV['UNTAPPD_URL']
  ID = ENV['UNTAPPD_ID']
  SECRET = ENV['UNTAPPD_SECRET']

  attr_reader :beer, :brewery

  def initialize(query)
    @beer = {}
    @url =
      "#{URL}search/beer?q=#{query}&client_secret=#{SECRET}&client_id=#{ID}"
  end

  def execute
    search_beer
    beer_info
    formatted_response
  end

  def search_beer
    data = make_request(@url)
    return unless data

    beer_data = data['response']['beers']['items'][0]['beer']
    @brewery = data['response']['beers']['items'][0]['brewery']
    @beer.merge!(beer_data)
  end

  def beer_info
    return if @beer.empty?

    data = make_request(generate_info_url)
    return unless data

    beer_data = data['response']['beer']
    @beer.merge!(beer_data)
  end

  def generate_info_url
    "#{URL}beer/info/#{@beer['bid']}?client_secret=#{SECRET}&client_id=#{ID}&compact=true"
  end

  def make_request(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return unless response

    JSON.parse(response)
  end

  def rating
    (@beer['rating_score'] * 100).round / 100.0
  end

  def ibu
    @beer['beer_ibu'] != 0 ? beer['beer_ibu'] : '❓'
  end

  def formatted_response
    <<~HEREDOC
      *Nombre* #{@beer['beer_name']}
      *Cervecería* #{@brewery['brewery_name']}
      ⭐️ #{rating}
      *País* #{@brewery['country_name']}
      *Graduación alcohólica* #{beer['beer_abv']}
      *IBU* #{ibu}
      *Estilo* #{@beer['beer_style']}
    HEREDOC
  end
end
