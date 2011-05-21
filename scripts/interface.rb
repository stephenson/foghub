require 'fogbugz'

@interface = Fogbugz::Interface.new(YAML.load_file('config.yml')[:fogbugz])
@interface.authenticate
