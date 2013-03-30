# Make sure we're using nanoc 3.0 or higher
if Nanoc3::VERSION < '3.0'
  puts 'WARNING:'
  puts 'You need nanoc 3.0 or higher to compile this site. If you really ' +
       'want to compile this site with an older version of nanoc, set ' +
       'FORCE to true in your environment.'

  exit unless ENV['FORCE'] == 'true'
end

module StoneshipSite
  module Helpers
  end
end

# Returns the latest essay, article or review
def latest_item
  @items.select { |item| %w( article essay review ).include?(item[:kind]) }.
         sort_by { |item| item[:published_on] }.last
end

# Returns the item with the given identifier.
def item_named(identifier)
  @items.find { |item| item.identifier == identifier }
end

def rating_stars_for(item)
  full_star  = '<span class="full">&#9733;</span>'
  empty_star = '<span class="empty">&#9734;</span>'

  (full_star * item[:rating]) + (empty_star * (5-item[:rating]))
end

def format_date(date)
  "#{date.mon.to_mon_s} #{date.mday.ordinal}, #{date.year}"
end
