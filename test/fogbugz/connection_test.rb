require_relative './fogbugz_helper.rb'

class Interface < FogTest
  def setup
    Fogbugz.adapter[:http] = Fogbugz::Adapter::HTTP::Mock
    Fogbugz.adapter[:xml] = Fogbugz::Adapter::XML::Mock

    @fogbugz = Fogbugz::Interface.new
  end

  test 'when instantiating options should be overwriting and be publicly available' do
    OPTIONS = {:sample => 'option'}
    f = Fogbugz::Interface.new(OPTIONS)
    assert_equal OPTIONS, f.options
  end

  test 'adapters should be mocked' do
    assert_instance_of Fogbugz::Adapter::HTTP::Mock, @fogbugz.http
    assert_instance_of Fogbugz::Adapter::XML::Mock, @fogbugz.xml
  end
end
