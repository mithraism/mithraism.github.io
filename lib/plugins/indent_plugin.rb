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
