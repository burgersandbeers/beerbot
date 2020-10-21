# frozen_string_literal: true

class Covid
  attr_reader :data

  def initialize
    @data = {}
    @url = 'https://covid19.mathdro.id/api/countries/chile'
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
    confirmados = @data['confirmed']['value']
    recuperados = @data['recovered']['value']
    muertos = @data['deaths']['value']
    <<~HEREDOC
        Hay #{confirmados} casos confirmados, #{recuperados} recuperados y #{muertos} muertos por Covid-19.
    HEREDOC
  end
end
