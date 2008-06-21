# Make sure we're using nanoc 2.1 or higher
if Nanoc::VERSION < '2.1'
  puts 'WARNING:'
  puts 'You need nanoc 2.1 or higher to compile this site. If you really ' +
       'want to compile this site with an older version of nanoc, set ' +
       'FORCE to true in your environment.'

  exit unless ENV['FORCE'] == 'true'
end

# Extensions - built-in
include Nanoc::Extensions::Blogging
include Nanoc::Extensions::LinkTo
include Nanoc::Extensions::XMLSitemap

# Extensions - custom
include Nanoc::Extensions::HTMLSitemap

# Returns a sorted list of articles for the given year.
def articles_for_year(year)
  @pages.select { |page| page.kind == 'article' and page.created_at.year == year }.sort_by { |page| page.created_at }.reverse
end

# Convenience function for performing a calculation and yielding the result.
# This prevents local variables from being created.
def with(obj)
  yield obj
end

# Returns the asset with the given asset ID.
def asset(asset_id)
  @assets.find { |asset| asset.asset_id == asset_id }
end
