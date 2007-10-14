def sorted_articles
  @pages.select do |page|
    page.kind == 'article'
  end.sort do |x,y|
    y.created_at <=> x.created_at
  end
end

def atom_feed(params={})
  nanoc_require 'builder'

  # Extract parameters
  limit = params.has_key?(:limit) ? params[:limit] : 5

  # create builder
  buffer = ''
  xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)

  # build feed
  xml.instruct!
  xml.feed(:xmlns => 'http://www.w3.org/2005/Atom') do
    xml.id      @page.base_url + '/'
    xml.title   @page.title
    xml.updated sorted_articles.first.created_at.to_iso8601_time
    xml.link(:rel => 'alternate', :href => @page.base_url)
    xml.link(:rel => 'self', :href => feed_url_for(@page))
    xml.author do
      xml.name  @page.author_name
      xml.uri   @page.author_uri
    end
    sorted_articles.first(limit).each do |a|
      xml.entry do
        xml.id        atom_tag_for(a)
        xml.title     a.title, :type => 'html'
        xml.published a.created_at.to_iso8601_time
        xml.updated   a.file.mtime.to_iso8601_time
        xml.link(:rel => 'alternate', :href => url_for(a))
        xml.content   a.content, :type => 'html'
        xml.summary   a.excerpt, :type => 'html' unless a.excerpt.nil?
      end
    end
  end

  buffer
end

def url_for(page)
  if page.custom_path_in_feed.nil?
    page.base_url + page.path
  else
    page.base_url + page.custom_path_in_feed
  end
end

def feed_url_for(page)
  page.feed_url || page.base_url + page.path
end

def atom_tag_for(page)
  'tag:' + page.base_url.sub(/.*:\/\/(.+?)\/?$/, '\1') + ',' + page.created_at.to_iso8601_date + ':' + page.path
end

class Time
  def to_iso8601_date
    self.strftime("%Y-%m-%d")
  end

  def to_iso8601_time
    self.gmtime.strftime("%Y-%m-%dT%H:%M:%SZ")
  end
end
