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
    hora = @data['horaConsulta']
    calles = @data['descripcion']
    "Paradero #{paradero}, en calle #{calles}. Hora de consulta #{hora}"
  end
end
