def breadcrumbs(params={})
  # Extract parameters
  separator = params[:separator] || ' > '
  root      = params[:root]      || 'Home'

  # Find page paths
  memo = []
  trail_paths = @page.path.sub(/^\//, '').split('/').map { |part| memo << part; '/' + memo.join('/') + '/' }

  # Find pages
  trail_pages = trail_paths.map { |path| @pages.select { |p| p.path == path }.first }
  trail_hashes = [ { :title => root, :path => '/' } ] + trail_pages.map { |p| { :title => p.title, :path => p.path } }

  # Convert to links and join
  trail_hashes.map { |p| link_to_unless_current(p[:path], h(p[:title])) }.join(separator)
end
