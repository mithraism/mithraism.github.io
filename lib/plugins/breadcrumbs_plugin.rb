def breadcrumbs(params={})
  # Extract parameters
  separator = params[:separator] || ' > '

  # Build stack
  stack = @page.unfold { |page| page.parent }.reverse

  # Convert to text
  stack.map { |page| link_to_unless_current(page.path, h(page.title)) }.join(separator)
end
