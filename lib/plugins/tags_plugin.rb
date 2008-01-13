require 'uri'

def tags_for(page, params={})
  base_url  = params[:base_url]  || 'http://technorati.com/tag/'
  none_text = params[:none_text] || '(none)'
  separator = params[:separator] || ', '

  if page.tags.nil? or page.tags.empty?
    none_text
  else
    page.tags.collect { |tag| link_for_tag(tag, base_url) }.join(separator)
  end
end

def link_for_tag(tag, base_url)
  %[<a href="#{base_url}#{URI.escape(tag)}" rel="tag">#{tag}</a>]
end
