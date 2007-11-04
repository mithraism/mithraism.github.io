require 'xmlrpc/client'

task :ping do
  puts '===== PINGING TECHNORATI'
  client = XMLRPC::Client.new2("http://rpc.technorati.com/rpc/ping")
  client.call("weblogUpdates.ping", "Stoneship", "http://stoneship.org/")
end
