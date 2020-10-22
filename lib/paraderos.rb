# frozen_string_literal: true

class Paradero
  attr_reader :data

  def initialize(query)
    @data = {}
    @url = "https://api.xor.cl/ts/?paradero=#{query}"
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
    paradero = @data['id']
    output = ''
    if paradero != "NULL"
      hora = @data['horaConsulta']
      calles = @data['descripcion']
      output += "Paradero #{paradero}, en calle #{calles}. Hora de consulta #{hora}\n-----------------------------------\n"
		  @data['servicios'].each do |linea|
		  	micro = linea['servicio']
        patente = linea['patente']
        tiempo = linea['tiempo']
        distancia = linea['distancia']
		  	output += "*Linea:* #{micro}\n*Patente* #{patente}\n*Tiempo:* #{tiempo}\n*Distancia:* #{distancia}\n-----------------------------------\n"
		  end
    else
      output += "#{calles}"
    end
    output
  end
end
