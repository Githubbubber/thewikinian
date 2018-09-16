<<<<<<< HEAD
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
=======
require 'bundler/setup'
require "pg"
require "pry"
require "sinatra/base"
# require "sinatra/reloader"
require "faker"

require_relative "server"

# require "method::override"
run TheWikinian::Server
>>>>>>> e8de6b16de3809b790761d5ef53da908863f3791
