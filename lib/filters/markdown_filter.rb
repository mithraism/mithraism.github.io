module Nanoc::Filter::MarkdownFilter
  class MarkdownFilter < Nanoc::Filter

    identifiers :markdown, :bluecloth

    def run(content)
      nanoc_require 'BlueCloth'

      BlueCloth.new(content).to_html
    end

  end
end
