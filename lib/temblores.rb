# frozen_string_literal: true

class Temblor
	attr_reader :data

	def initialize
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
		@data.each do |sismo|
			ubicacion = sismo.geoReferencia
			magnitud = sismo.magnitudes.magnitud
			hora = sismo.fechaLocal
			<<~HEREDOC
				*Ubicación:* #{ubicacion}
				*Hora* #{hora}
      	*Magnitud:* #{magnitud}
				-----------------------------------
			HEREDOC
		end
	end
end
	