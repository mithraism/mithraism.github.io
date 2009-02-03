module Nanoc::Filters

  class OriginalMarkdown < Nanoc::Filter

    identifier :original_markdown

    def run(content)
      open('|perl lib/Markdown.pl', 'r+') do |io|
        io.write(content)
        io.close_write
        io.read
      end
    end

  end

end
