# frozen_string_literal: true

class SaldoBip
    attr_reader :data
  
    def initialize
      @data = {}
      @url = "https://api.xor.cl/bip/?n=#{query}"
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
			valida = @data['valida']
			if valida
				estado = @data['estadoContrato']
				saldo = @data['saldoBip']
				<<~HEREDOC
					La Tarjeta se encuentra con #{estado},
					y posee un saldo de #{saldo}.
				HEREDOC
			else
				tipo = @data['tiposContrato']
				<<~HEREDOC
        	#{tipo}.
				HEREDOC
			end
    end
  end