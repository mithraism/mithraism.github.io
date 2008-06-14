begin ; require 'rubygems' ; rescue LoadError ; end
require 'nanoc'

desc 'removes all compiled pages from the output directory'
task :clean do
  # Load site
  site = Nanoc::Site.from_cwd rescue Nanoc::Site.new(YAML.load_file('config.yaml'))
  site.load_data

  # Remove all compiled pages
  page_rep_paths = site.pages.map { |p| p.reps }.flatten.map { |r| r.disk_path }
  page_rep_paths.each do |path|
    FileUtils.remove_entry_secure(path) if File.file?(path)
  end

  # Remove all compiled assets
  asset_rep_paths = site.assets.map { |a| a.reps }.flatten.map { |r| r.disk_path }
  asset_rep_paths.each do |path|
    FileUtils.remove_entry_secure(path) if File.file?(path)
  end
end
