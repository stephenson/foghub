require 'sinatra'
require_relative './parser'

class Foghub < Sinatra::Base
  post '/commit' do
    'hello world'
  end
end
