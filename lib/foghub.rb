require 'sinatra'
require_relative 'foghub/parser'

require_relative './foghub/parser'

class Foghub < Sinatra::Base
  attr_accessor :instance, :config

  def config
    @config ||= YAML.load_file('./config.yml')
  end

  def fogbugz
    unless @instance
      @instance ||= Fogbugz::Interface.new(config[:fogbugz])
      interface.authenticate
    end

    @instance
  end

  post '/commit' do
    params["commits"].each do |raw_commit|
      commit = CommitParser.new(raw_commit["message"])
      commit.aliases = config[:aliases]

      if commit.review? && commit.reviewers.length >= 1
        fogbugz.command(:new, :sPersonAssignedTo => commit.reviewer_ids.first)
      else
        fogbugz.command(:edit, :ixBug => commit.cases.first, :sEvent => raw_commit["message"])
      end
    end
    
    status 200
  end
end
