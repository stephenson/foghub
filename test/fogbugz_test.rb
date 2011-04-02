require_relative './test_helper'

class FogbugzHelperMethods < MiniTest::Unit::TestCase
  def setup
    @fogbugz = Fogbugz.new('http://sample.fogbugz.com', 'sirup@sirup@sirupsen.com.com', 'seekrit')
  end

  def test_that_needed_attributes_are_available_and_correct
    @fogbugz.url = 'http://sample.fogbugz.com'
    @fogbugz.email = 'sirup@sirupsen.com'
    @fogbugz.password = 'seekrit'
  end

  def test_params_are_escaped_correctly
    escaped = @fogbugz.send(:escape_params, {:hello => 'world', :this => 'is'})

    assert_equal "hello=world&this=is", escaped
  end
end

class FogbugzRequestMethods < MiniTest::Unit::TestCase
  def setup
    @fogbugz = Fogbugz.new('http://sample.fogbugz.com', 'sirup@sirupsen.com', 'seekrit')
  end

  def test_it_fetches_token_and_cleans_for_username_and_password_when_authenticating
    mock(response = Object.new)
    mock(response).body { '<response><token>seekrit</token></response>'}
    mock(Typhoeus::Request).get("http://sample.fogbugz.com/email=sirup%40sirupsen.com&password=seekrit&cmd=logon") { response }

    @fogbugz.authenticate

    assert_equal 'seekrit', @fogbugz.token
  end

  def test_the_general_request
    mock(Typhoeus::Request).get("http://sample.fogbugz.com/param1=burger&param2=cheese&cmd=sample") { 'data' } 
    mock(@fogbugz).parse('data') { 'parsed data' }

    response = @fogbugz.request(:sample, :param1 => :burger, :param2 => :cheese)

    assert_equal 'parsed data', response
  end

  def test_the_general_request_wants_to_send_along_token_once_its_defined
    mock(Typhoeus::Request).get("http://sample.fogbugz.com/param1=burger&param2=cheese&cmd=sample&token=valid_token") { 'data' } 
    mock(@fogbugz).parse('data') { 'parsed data' }

    @fogbugz.token = 'valid_token'
    response = @fogbugz.request(:sample, :param1 => :burger, :param2 => :cheese)

    assert_equal 'parsed data', response
  end
end
