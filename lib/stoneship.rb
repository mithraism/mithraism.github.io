########## NAVIGATION

def link_to_unless_current(path, text)
  if @page[:path] == path
    "<span class=\"active\">#{text}</span>"
  else
    "<a href=\"#{path}\">#{text}</a>"
  end
end

########## MISCELLANEOUS

def permalink(a_string)
  '<a href="#' + a_string + '" class="permalink" rel="bookmark" title="Permanent link to this section">#</a>'
end
