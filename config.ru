require 'rubygems'
require 'bundler'
Bundler.require
YAML::ENGINE.yamler = "psych"
require './server'
run Sinatra::Application