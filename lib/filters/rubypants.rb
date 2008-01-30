module Nanoc::Filters
  class RubypantsFilter < Nanoc::Filter

    identifiers :rubypants

    def run(content)
      RubyPants.new(content).to_html
    end

  end
end
