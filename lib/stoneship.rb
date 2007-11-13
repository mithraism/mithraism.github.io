# Make sure we're using nanoc 2.0 or higher
if Nanoc::VERSION < '2.0.'
  puts 'WARNING:'
  puts 'You need nanoc 1.7 or higher to compile this site. If you really want to'
  puts 'compile this site with an older version of nanoc, set FORCE to true in your'
  puts 'environment.'
  puts
  exit unless ENV['FORCE'] == 'true'
end

def permalink(a_string)
  '<a href="#' + a_string + '" class="permalink" rel="bookmark" title="Permanent link to this section">#</a>'
end
