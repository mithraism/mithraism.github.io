# Make sure we're using nanoc 1.6 or higher

if Nanoc::VERSION < '1.6'
  puts 'WARNING:'
  puts 'You need nanoc 1.6 or higher to compile this site. If you really want to'
  puts 'compile this site with an older version of nanoc, set FORCE to true in your'
  puts 'environment.'
  puts
  exit unless ENV['FORCE'] == 'true'
end

########## NAVIGATION

def link_to_unless_current(path, text, params={})
  if @page[:path] == path
    "<span class=\"active\">#{text}</span>"
  else
    "<a #{params.inject('') { |memo, (key, value)| memo + "#{key.to_s}=\"#{value.to_s}\" " } }href=\"#{path}\">#{text}</a>"
  end
end

def breadcrumbs(params={})
  # Extract parameters
  separator = params[:separator] || ' &rarr; '
  root      = params[:root]      || 'Home'

  # Find page paths
  memo = []
  trail_paths = @page.path.sub(/^\//, '').split('/').map { |part| memo << part; '/' + memo.join('/') + '/' }

  # Find pages
  trail_pages = trail_paths.map { |path| @pages.select { |p| p.path == path }.first }
  trail_hashes = [ { :title => root, :path => '/' } ] + trail_pages.map { |p| { :title => p.title, :path => p.path } }

  # Convert to links and join
  trail_hashes.map { |h| link_to_unless_current(h[:path], h[:title]) }.join(separator)
end

def print_sitemap(sitemap, indentation=0, sitemap_buffer='')
  puts 'beep ' + indentation.to_s
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

########## MISCELLANEOUS

def permalink(a_string)
  '<a href="#' + a_string + '" class="permalink" rel="bookmark" title="Permanent link to this section">#</a>'
end

class String

  def indent(amount, string="\t")
    is_on = true
    self.split("\n").collect do |line|
      # indent line
      result = is_on ? string*amount + line : line

      # turn indenting on or off for lines with preformatted text
      if line =~ /<pre/ and line !~ /<\/pre>/
        is_on = false
      elsif line !~ /<pre/ and line =~ /<\/pre>/
        is_on = true
      end

      # return result
      result
    end.join("\n")
  end

end
