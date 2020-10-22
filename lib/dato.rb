# frozen_string_literal: true

class Dato
    attr_reader :data
  
    def initialize
      @data = {}
      @url = 'https://uselessfacts.jsph.pl/random.json?language=en'
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
      @data['text']
    end
  end
  