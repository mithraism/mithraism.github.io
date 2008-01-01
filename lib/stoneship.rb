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
  @pages.select do |page|
    page.kind == 'article'
  end.select do |article|
    article.created_at.year == year
  end.group_by do |article|
    article.created_at.month
  end.map do |month, articles|
    [ month, articles.sort_by { |article| article.created_at } ]
  end.sort.reverse
end
