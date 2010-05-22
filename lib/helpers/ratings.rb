module StoneshipSite::Helpers
  
  module Ratings

    def rating_code_for(item)
      full_star  = '&#9733;'
      empty_star = '&#9734;'

      code = ''

      code << %[<abbr class="rating" title="#{item[:rating]}">]
      code << '<span class="full">'  + (full_star  * (  item[:rating])) + '</span>'
      code << '<span class="empty">' + (empty_star * (5-item[:rating])) + '</span>'
      code << '</abbr>'

      code
    end

  end

end
