require 'time'

class Date
  def format_nicely
    "#{Date::MONTHNAMES[mon]} #{mday}, #{year}"
  end

  def to_atom_date
    self.strftime("%Y-%m-%d")
  end
end

module Enumerable
  def group_by # Mercilessly stolen from Rails
    inject({}) do |groups, element|
      (groups[yield(element)] ||= []) << element
      groups
    end
  end
end

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

class Time
  def format_nicely
    "#{Date::MONTHNAMES[mon]} #{mday}, #{year}"
  end

  def to_iso8601_date
    self.strftime("%Y-%m-%d")
  end
  alias to_atom_date to_iso8601_date

  def to_iso8601_time
    self.gmtime.strftime("%Y-%m-%dT%H:%M:%SZ")
  end
  alias to_atom_time to_iso8601_time
end

def html_escape(a_string)
  a_string.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub('"', '&quot;')
end

alias h html_escape
