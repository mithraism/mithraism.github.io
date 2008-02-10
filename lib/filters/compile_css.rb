module Nanoc::Filters
  class CompileCSSFilter < Nanoc::Filter

    identifiers :compile_css

    def run(content)
      definitions = {}

      # Convert CSS
      new_css = content.inject([]) do |lines, line|
        if line =~ /^@define\s+([-a-z0-9]+)\s+(.*?);/
          # Set definition
          definitions[$1] = $2
          lines
        elsif line =~ /constant\((.*?)\)/
          # Lookup definition
          if definitions[$1].nil?
            puts 'ERROR: unknown definition: ' + $1
            lines
          else
            lines + [ line.sub(/constant\(.*?\)/, definitions[$1]) ]
          end
        else
          # Do nothing
          lines + [ line ]
        end
      end.join
    end

  end
end
