# Beerbot https://t.me/burgers_and_beers_bot

## Install

`bundle install`

## Start

`ruby bin/main.rb`

## Action sample

```ruby
class Sample
  attr_reader :data

  def initialize(query)
    @data = {}
    @url = "https://myurl.com?query=#{query}"
  end

  def execute
    make_request
    formatted_response
  end

  def make_request
    uri = URI(@url)
    response = Net::HTTP.get(uri)
    return unless response

    @data = JSON.parse(response)
  end

  def formatted_response
    "This is my response: #{@data}"
  end
end
```
