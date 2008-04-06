require 'xmlrpc/client'

desc 'pings web sites to notify your web site has been updated'
task :ping do
  # Configuration
  weblog_title = 'Stoneship'
  weblog_url   = 'http://stoneship.org/'
  services     = {
    'Technorati' => 'http://rpc.technorati.com/rpc/ping',
    'FeedBurner' => 'http://ping.feedburner.com',
    'blo.gs'     => 'http://ping.blo.gs'
  }

  # Don't touch this
  services.each_pair do |name, url|
    print format('%20s', name) + ': '
    client = XMLRPC::Client.new2(url)
    result = client.call("weblogUpdates.ping", weblog_title, weblog_url)
    puts result['flerror'] ? 'ERROR! ' + result['message'] : 'OK'
  end
end
