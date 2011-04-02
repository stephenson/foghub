require 'cgi'
require 'typhoeus'
require 'crack/xml'

class Fogbugz
  attr_accessor :url, :token, :email, :password

  def initialize(url, email, password)
    @url, @email, @password = url, email, password
  end

  def authenticate
    @token ||= logon['token']
  end
  alias_method :authenticated?, :authenticate

  def request(cmd, params = {})
    params.merge!({:cmd => cmd}) && @token && params.merge!({:token => @token})

    parse Typhoeus::Request.get(request_url(params))
  end

  private
  def logon
    request(:logon, :email => @email, :password => @password)
  end

  def parse(response)
    Crack::XML.parse(response.body)['response']
  end

  def request_url(params)
    "#{@url}/#{escape_params(params)}"
  end

  def escape_params(params)
    params.collect { |key, val| "#{CGI::escape(key.to_s)}=#{CGI::escape(val.to_s)}" }.join('&') unless params.nil?
  end
end
