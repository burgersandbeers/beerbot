# frozen_string_literal: true

require 'telegram/bot'
require_relative 'beer.rb'
require_relative 'covid.rb'
require_relative 'paraderos.rb'
require_relative 'dato.rb'

token = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message
    case message
    when '/start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Hola, #{message.from.first_name}"
      )
    when '/stop'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Chao, #{message.from.first_name}"
      )
    when Telegram::Bot::Types::Message
      case message.text
      when /^beer\s+.*$/
        query = message.text.split(' ')[1..-1].join(' ')
        beer = Beer.new(query)
        data = beer.execute
        bot.api.send_message(
          chat_id: message.chat.id,
          text: data,
          parse_mode: 'Markdown'
        )
      when /^covid/
        covid = Covid.new
        data = covid.execute
        bot.api.send_message(
          chat_id: message.chat.id,
          text: data
        )
      when /^paradero\s+.*$/
        query = message.text.split(' ')[1..-1].join(' ')
        paradero = Paradero.new(query)
        data = paradero.execute
        bot.api.send_message(
          chat_id: message.chat.id,
          text: data
        )
      when /^dato/
        dato = Dato.new
        data = dato.execute
        bot.api.send_message(
          chat_id: message.chat.id,
          text: data
        )
      else
        puts "Message @#{message.from.username}: #{message.text}"
      end
    when Telegram::Bot::Types::InlineQuery
      puts "InlineQuery @#{message.from.username}: #{message.query} and #{message.id}"
    end
  end
end
