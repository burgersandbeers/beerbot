# frozen_string_literal: true

class Temblor
	attr_reader :data

	def initialize(query)
		@data = {}
		@url = "https://api.xor.cl/sismo/?fecha=#{query}"
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
		@data.each do |sismo|
			ubicacion = sismo['geoReferencia']
			magnitud = sismo['magnitudes'][0]['magnitud']
			hora = sismo['fechaLocal']
			output += "*Ubicación:* #{ubicacion}\n*Hora* #{hora}\n*Magnitud:* #{magnitud}\n-----------------------------------\n"
		end
		output
	end
end
