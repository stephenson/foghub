require_relative './interface'

@interface.command(:listCategories)["categories"]["category"].each do |category|
  puts "##{category["ixCategory"]} #{category["sCategory"]}"
end
