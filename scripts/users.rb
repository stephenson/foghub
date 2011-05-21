require 'fogbugz'

interface = Fogbugz::Interface.new(YAML.load_file('config.yml')[:fogbugz])
interface.authenticate

interface.command(:listPeople)["people"]["person"].each do |person|
  puts "##{person["ixPerson"]} #{person["sFullName"]}"
end
