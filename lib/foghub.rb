require 'sinatra'
require_relative './parser'

class Foghub < Sinatra::Base
  post '/commit' do
    # get commit
    # parse commit for #case and #review
    # if has #review tag AND >= 1 tagged people, create a code review for #case
    # else, simply associate the commit with the case
    'hello world'
  end
end
