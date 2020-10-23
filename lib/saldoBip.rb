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
		  output = ''
			valida = @data['valida']
			if valida
				estado = @data['estadoContrato']
        saldo = @data['saldoBip']
        output += "La Tarjeta se encuentra con #{estado},\ny posee un saldo de #{saldo}."
			else
        tipo = @data['tiposContrato']
        output += "#{tipo}"
      end
      output
    end
  end