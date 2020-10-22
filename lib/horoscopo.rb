# frozen_string_literal: true

class Horoscopo
    attr_reader :data
  
    def initialize(query)
      @data = {}
      @url = 'https://api.xor.cl/tyaas/'
      @signo = query
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
        info = @data['horoscopo'][@signo]
        amor = info['amor']
        salud = info['salud']
        dinero = info['dinero']
        numero = info['numero']
        color = info['color']
      <<~HEREDOC
        ❤️ #{amor}
        😷 #{salud}
        💰 #{dinero}
        🔢 #{numero}
        🎨 #{color}
      HEREDOC
    end
  end
  