module Nanoc3::Filters

  class OriginalMarkdown < Nanoc3::Filter

    identifier :original_markdown

    def run(content, params={})
      open('|perl lib/Markdown.pl', 'r+') do |io|
        io.write(content)
        io.close_write
        io.read
      end
    end

  end

end
