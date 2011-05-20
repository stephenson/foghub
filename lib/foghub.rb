require 'sinatra'
require_relative 'foghub/parser'

class Foghub < Sinatra::Base
  post '/commit' do
    # get commit
    # parse commit for #case and #review
    # if has #review tag AND >= 1 tagged people
    #   find Fogbugz ID from alias
    #   create a code review for #case assigned to that ID
    # else, simply associate the commit with the case
    'hello world'
  end
end
