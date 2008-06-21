def link_to_unless_current(path, text, params={})
  if @page.path == path
    "<span class=\"active\" title=\"You're here.\">#{h text}</span>"
  else
    "<a #{params.inject('') { |memo, (key, value)| memo + "#{key.to_s}=\"#{value.to_s}\" " } }href=\"#{path}\">#{h text}</a>"
  end
end
