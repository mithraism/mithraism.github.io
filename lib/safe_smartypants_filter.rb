class String

  # A rather ugly hack that prevents smartypants from being used
  def partial_smartypants(delimiter, pre, post)
    nanoc_require 'rubypants'
    arr = self.split(delimiter)
    is_erb = arr.first.empty?
    arr.map do |substring|
      is_erb = !is_erb
      !is_erb ?  pre + substring + post : RubyPants.new(substring).to_html
    end.join('')
  end

end

register_filter 'safe_smartypants', 'safe_rubypants' do |page, pages, config|
  page.content.partial_smartypants(/<%|%>/, '<%', '%>')
end

register_filter 'deactivatable_smartypants', 'deactivatable_rubypants' do |page, pages, config|
  page.content.partial_smartypants(/__BEGIN_NO_SMARTYPANTS__|__END_NO_SMARTYPANTS__/, '', '')
end
