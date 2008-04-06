require 'time'

class Fixnum
  def to_mon_s
    Date::MONTHNAMES[self]
  end

  def to_abbr_mon_s
    Date::ABBR_MONTHNAMES[self]
  end
end

class Numeric
  def ordinal
    if (10...20).include?(self) then
      self.to_s + 'th'
    else
      self.to_s + %w{th st nd rd th th th th th th}[self % 10]
    end
  end
end

class Object
  def unfold
    obj = self
    arr = []

    while obj
      arr << obj
      obj = yield(obj)
    end

    arr
  end
end

def html_escape(a_string)
  a_string.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub('"', '&quot;')
end

alias h html_escape
