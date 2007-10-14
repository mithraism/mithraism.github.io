require 'open-uri'

# Cache
$delicious_links = {}

def delicious_links_for_user(user)
  nanoc_require 'json'

  if $delicious_links[user].nil?
    # Load the data
    data = open("http://del.icio.us/feeds/json/#{user}?raw").string
    
    # Convert it into something more Ruby-ish
    parsed_data = JSON.parse(data).inject([]) do |memo, item|
      memo << { :url         => item['u'],
                :title       => item['d'],
                :description => item['n'],
                :tags        => item['t'] }
    end
    
    # Cache it
    $delicious_links[user] = parsed_data
  end
  
  # Return entry from cache
  $delicious_links[user]
end
