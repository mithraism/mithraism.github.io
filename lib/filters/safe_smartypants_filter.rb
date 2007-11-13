module Nanoc::Filter::DeactivatableSmartyPantsFilter
  class DeactivatableSmartyPantsFilter < Nanoc::Filter

    identifiers :deactivatable_smartypants, :deactivatable_rubypants

    # This is a rather ugly hack that prevents smartypants from being used
    def run(content)
      nanoc_require 'rubypants'

      delimiter = /__BEGIN_NO_SMARTYPANTS__|__END_NO_SMARTYPANTS__/

      arr = content.split(delimiter)
      is_erb = arr.first.empty?
      arr.map do |substring|
        is_erb = !is_erb
        !is_erb ?  substring : RubyPants.new(substring).to_html
      end.join('')
    end

  end
end
