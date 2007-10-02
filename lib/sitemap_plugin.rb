def try_require(s) ; begin ; require s ; rescue LoadError ; end ; end

try_require 'rubygems'

begin
  require 'builder'
rescue LoadError
  puts 'ERROR: You need "builder" -- gem install builder'
  exit!
end

def sitemap
  # create builder
  buffer = ''
  xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)

  # build sitemap
  xml.instruct!
  xml.urlset(:xmlns => 'http://www.google.com/schemas/sitemap/0.84') do
    @pages.reject { |p| p[:is_hidden] }.each do |page|
      xml.url do
        xml.loc         page.base_url + page.path
        xml.lastmod     page.file.mtime.to_iso8601_date
        xml.changefreq  page.changefreq unless page.changefreq.nil?
        xml.priority    page.priority unless page.priority.nil?
      end
    end
  end

  buffer
end

class Time
  def to_iso8601_date
    self.strftime("%Y-%m-%d")
  end
end
