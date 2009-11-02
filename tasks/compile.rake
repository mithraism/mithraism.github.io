task :copy_assets do
  puts '=== copying assets...'
  system "rsync -gprt --partial static/ output"
end

task :compile do
  puts '=== compiling...'
  system "nanoc3 co"
end

task :build => [ :copy_assets, :compile ]
