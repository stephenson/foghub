require_relative './fogbugz_helper.rb'

class FogTest
  CREDENTIALS = {
    :email    => "test@test.com",
    :password => 'seekrit',
    :uri      => 'http://fogbugz.test.com'
  }
end

class BasicInterface < FogTest
  def setup
    Fogbugz.adapter[:http] = MiniTest::Mock
    Fogbugz.adapter[:xml] = MiniTest::Mock

    @fogbugz = Fogbugz::Interface.new(CREDENTIALS)
  end

  test 'when instantiating options should be overwriting and be publicly available' do
    assert_equal CREDENTIALS, @fogbugz.options
  end

  test 'adapters should be mocked' do
    assert_instance_of MiniTest::Mock, @fogbugz.http
    assert_instance_of MiniTest::Mock, @fogbugz.xml
  end
end

class InterfaceRequests < FogTest
  test 'authentication should send correct parameters' do

    fogbugz = Fogbugz::Interface.new(CREDENTIALS)
    fogbugz.http.expect(:request, 'token', [:logon, 
                                            :email => CREDENTIALS[:email],
                                            :password => CREDENTIALS[:password]])
    fogbugz.authenticate

    assert fogbugz.http.verify
  end

  test 'requesting with an action should send along token and correct parameters' do
    fogbugz = Fogbugz::Interface.new(CREDENTIALS)
    fogbugz.token = 'token'
    fogbugz.http.expect(:request, nil, [:search, {:token => 'token', :params => {:q => 'case'}}])
    fogbugz.command(:search, :q => 'case')

    assert fogbugz.http.verify
  end

  test 'throws an exception if #command is requested with no token' do
    fogbugz = Fogbugz::Interface.new(CREDENTIALS)
    fogbugz.token = nil

    assert_raises Fogbugz::Interface::RequestError do
      fogbugz.command(:search, :q => 'case')
    end
  end
end
