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
