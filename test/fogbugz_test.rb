require_relative './test_helper'

class FogbugzHelperMethods < MiniTest::Unit::TestCase
  def setup
    @fogbugz = Fogbugz.new('http://sample.fogbugz.com', 'sirup@sirup@sirupsen.com.com', 'seekrit')
  end

  test "needed attributes are correct" do
    @fogbugz.url = 'http://sample.fogbugz.com'
    @fogbugz.email = 'sirup@sirupsen.com'
    @fogbugz.password = 'seekrit'
  end

  test "params are escaped correctly" do
    escaped = @fogbugz.send(:escape_params, {:hello => 'world', :this => 'is'})

    assert_equal "hello=world&this=is", escaped
  end
end

class FogbugzRequestMethods < MiniTest::Unit::TestCase
  def setup
    @fogbugz = Fogbugz.new('http://sample.fogbugz.com', 'sirup@sirupsen.com', 'seekrit')
  end

  test "fetches token when authenticating" do
    mock(response = Object.new)
    mock(response).body { '<response><token>seekrit</token></response>'}
    mock(Typhoeus::Request).get("http://sample.fogbugz.com/email=sirup%40sirupsen.com&password=seekrit&cmd=logon") { response }

    @fogbugz.authenticate

    assert_equal 'seekrit', @fogbugz.token
  end

  test "general request" do
    mock(Typhoeus::Request).get("http://sample.fogbugz.com/param1=burger&param2=cheese&cmd=sample") { 'data' } 
    mock(@fogbugz).parse('data') { 'parsed data' }

    response = @fogbugz.request(:sample, :param1 => :burger, :param2 => :cheese)

    assert_equal 'parsed data', response
  end

  test "general request with token" do
    mock(Typhoeus::Request).get("http://sample.fogbugz.com/param1=burger&param2=cheese&cmd=sample&token=valid_token") { 'data' } 
    mock(@fogbugz).parse('data') { 'parsed data' }

    @fogbugz.token = 'valid_token'
    response = @fogbugz.request(:sample, :param1 => :burger, :param2 => :cheese)

    assert_equal 'parsed data', response
  end
end
