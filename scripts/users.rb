require_relative './interface'

@interface.command(:listPeople)["people"]["person"].each do |person|
  puts "##{person["ixPerson"]} #{person["sFullName"]}"
end
