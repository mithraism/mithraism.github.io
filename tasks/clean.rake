require 'rubygems'
require 'nanoc'

# Removes all 'active' files
task :clean do
  # Load site
  site = Nanoc::Site.from_cwd
  site.load_data

  # Remove all 'active' files
  site.pages.map { |page| page.path_on_filesystem }.each do |path|
    FileUtils.remove_entry_secure(path) if File.file?(path)
  end
end
