require 'net/http'
require 'uri'
require 'date'

class WitAI_Minimal
    @@key = 0
    @@message = 0
    def initialize(key, message)
      @@key = key
      @@message = message
    end
  
    def self.sendMessageRequest
        encodes_message = URI::encode(@@message.chomp)
        date = Date.today.to_s
        date = date.delete! '-'
        uri = URI.parse("https://api.wit.ai/message?v=" + date + "&q=" + encodes_message)
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "Bearer " + @@key.chomp
    
        req_options = {
        use_ssl: uri.scheme == "https",
        }
    
        response = Net::HTTP.start(uri.hostname, uri.port, req_options)
        real_response = response.request(request)
        puts "In Unparsed JSON Output, WitAI Said: " + real_response.body
    end
  end
