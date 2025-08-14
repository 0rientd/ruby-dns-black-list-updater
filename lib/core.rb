require 'faraday'

class Core
  def initialize
    @faraday = Faraday.new
    @dns_files = Dir.entries('./dns-files').select { |f| f.end_with?('.txt') }
    @exception_list = Dir.entries('./dns-exception-list').select { |f| f.end_with?('.txt') }

    puts "Fetching base list..."
    @base_list = Faraday.get('https://raw.githubusercontent.com/StevenBlack/hosts/refs/heads/master/alternates/gambling-porn-social/hosts')
    puts "Base list fetched successfully." if @base_list.success?
  end

  def update_dns_blacklist(consolidated_list)
    hosts_to_input = []

    @dns_files.each do |file|
      puts "Updating with the file: #{file}"
      
      File.open("./dns-files/#{file}", 'r') do |f|
        f.each_line do |line|
          next if line.strip.empty? || line.start_with?('#')
          hosts_to_input << line.strip
        end
      end
    end

    consolidated_list += custom_message.concat(hosts_to_input.join("\n"))
    consolidated_list
  end

  def update_exception_list(consolidated_list)
    hosts_to_remove = []

    @exception_list.each do |file|
      puts "Removing hosts from list: #{file}"

      File.open("./dns-exception-list/#{file}", 'r') do |f|
        f.each_line do |line|
          next if line.strip.empty? || line.start_with?('#')
          hosts_to_remove << line.strip
        end
      end
    end

    consolidated_list = remove_whatsapp_hosts(consolidated_list)

    consolidated_list = consolidated_list.split("\n").reject do |host|
      hosts_to_remove.include?(host.strip)
    end
    consolidated_list.join("\n")
  end

  def remove_whatsapp_hosts(consolidated_list)
    puts "Removing WhatsApp hosts with regex..."
    consolidated_list = consolidated_list.split("\n").reject do |host|
      host.match(/(\.|^)whatsapp\.com$/)
    end
    consolidated_list.join("\n")
  end

  def base_list
    @base_list.body
  end

  def dns_files
    @dns_files
  end

  def exception_list
    @exception_list
  end

  def faraday
    @faraday
  end

  def custom_message
    "\n# Latest update: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}\n" \
    "# This file is auto-generated.\n\n" \
    "# Custom hosts below:\n"
  end
end
