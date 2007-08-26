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

class String
  def indent(amount, string="\t")
    is_on = true
    self.split("\n").collect do |line|
      # indent line
      result = is_on ? string*amount + line : line

      # turn indenting on or off for lines with preformatted text
      if line =~ /<pre/
        is_on = false
      elsif line =~ /<\/pre>/
        is_on = true
      end

      # return result
      result
    end.join("\n")
  end
end
