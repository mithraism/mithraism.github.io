# FIXME: Make this prettier. A lot prettier. Because it's really, really ugly.

def print_sitemap(sitemap, indentation=0, sitemap_buffer='')
  sitemap_buffer << "\t" * indentation + '<ul>' + "\n"
  sitemap[:children].each do |child|
    sitemap_buffer << "\t" * (indentation+1) + '<li><a href="' + child[:page].path + '">' + ( child[:page].title.nil? ? '...' : child[:page].title ) + '</a></li>' + "\n"
    print_sitemap(child, indentation+1, sitemap_buffer) unless child[:children].empty?
  end
  sitemap_buffer << "\t" * indentation + '</ul>' + "\n"
  sitemap_buffer
end

def build_sitemap
  paths = @pages.reject { |page| page.is_hidden? }.map { |page| page.path }.sort
  cleaned_paths = paths.map { |path| path.gsub(/^\/|\/$/, '') }.reject { |path| path == '' }
  sitemap = cleaned_paths.inject({ :name => '', :children => [], :page => @pages.find { |page| page.path == '/' } }) do |root_page, path|
    path.split('/').inject(root_page) do |current_page, component|
      child_page = current_page[:children].find { |child| child[:name] == component }
      if child_page.nil?
        child_page = { :name => component, :children => [], :page => @pages.find { |page| page.path == '/' + path + '/' } }
        current_page[:children] << child_page
      end
      child_page
    end
    root_page
  end
  root_page = @pages.find { |page| page.path == '/' }
  { :name => root_page.title, :page => root_page, :children => [ sitemap ] }
end
