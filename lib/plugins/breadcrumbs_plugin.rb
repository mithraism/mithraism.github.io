def breadcrumbs(params={})
  # Extract parameters
  separator = params[:separator] || ' > '
  root      = params[:root]      || 'Home'

  stack = []

  # Build stack
  current = @page
  until current.nil? do
    stack << current
    current = current.parent
  end

  # Convert to text
  stack.reverse.map { |page| link_to_unless_current(page.path, h(page.parent.nil? ? root : page.title)) }.join(separator)
end
