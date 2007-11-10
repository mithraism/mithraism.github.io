def link_to_unless_current(path, text, params={})
  if @page.path == path
    "<span class=\"active\">#{text}</span>"
  else
    "<a #{params.inject('') { |memo, (key, value)| memo + "#{key.to_s}=\"#{value.to_s}\" " } }href=\"#{path}\">#{text}</a>"
  end
end
