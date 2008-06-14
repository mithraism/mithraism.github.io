# Make sure we're using nanoc 2.0 or higher
if Nanoc::VERSION < '2.0'
  puts 'WARNING:'
  puts 'You need nanoc 2.0 or higher to compile this site. If you really want to'
  puts 'compile this site with an older version of nanoc, set FORCE to true in your'
  puts 'environment.'
  puts
  exit unless ENV['FORCE'] == 'true'
end

def articles_for_year(year)
  @pages.select { |page| page.kind == 'article' and page.created_at.year == year }.sort_by { |page| page.created_at }.reverse
end

def with(obj)
  yield obj
end

def asset(asset_id)
  @assets.find { |asset| asset.asset_id == asset_id }
end
