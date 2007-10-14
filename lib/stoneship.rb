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
