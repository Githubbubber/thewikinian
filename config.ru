require 'bundler/setup'
require "pg"
require "pry"
require "sinatra/base"
# require "sinatra/reloader"
require "faker"

require_relative "server"

# require "method::override"
run TheWikinian::Server
