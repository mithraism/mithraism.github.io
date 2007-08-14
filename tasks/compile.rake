task :compile do
  puts '*** COPYING ASSETS'
  puts
  puts `rsync -rpgvP --exclude='.svn' assets/ output`

  puts

  puts '*** COMPILING SITE'
  puts
  puts `nanoc co`
end

task :default => :compile
