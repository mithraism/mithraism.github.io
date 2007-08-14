require 'xmlrpc/client'

task :ping do
  puts '*** PINGING TECHNORATI'
  puts
  
  client = XMLRPC::Client.new2("http://rpc.technorati.com/rpc/ping")
  client.call("weblogUpdates.ping", "Stoneship", "http://stoneship.org/")
end
