# frozen_string_literal: true

require 'dotenv/load'
require_relative '../lib/bot.rb'

puts 'Starting bot...'
Bot.new
puts '🤖 Alive'
