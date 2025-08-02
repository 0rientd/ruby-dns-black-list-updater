require_relative 'lib/core'

core = Core.new

puts "Updating DNS blacklist..."
consolidated_list = core.update_dns_blacklist(core.base_list)

puts "Updating exception list..."
consolidated_list = core.update_exception_list(consolidated_list)

File.write('consolidated-list/consolidated_list.txt', consolidated_list)
puts "Consolidated list saved to consolidated-list/consolidated_list.txt"