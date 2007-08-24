module LogFormatting
  COLORS = {
    :blue   => '#00f',
    :red    => '#f00',
    :purple => '#f0f',
    :orange => '#f60',
    :yellow => '#990',
    :gray   => '#666',
    :green  => '#090'
  }

  def format(params)
    self.collect { |line| line.strip.format_single(params) }.join("\n")
  end

  def format_single(params)
    formatted_line(params[:nicknames], params[:color], params[:type])
  end

  ##########

  def nickname_present?(nicknames)
    nicknames.select { |n| self =~ /^\(.+?\)  ?#{n}:/i }.length != 0
  end

  def formatted_line(nicknames, color, type)
    if nickname_present?(nicknames)
      if type == :bold_only
        gsub(/^\((.+?)\)  ?([^:]+): (.+?)$/i, '(\1)  [b]\2: \3[/b]')
      else
        gsub(/^\((.+?)\)  ?([^:]+): (.+?)$/i, '(\1)  [color=' + color.to_s + '][b]\2[/b]: \3[/color]')
      end
    else
      if type == :bold_only
        gsub(/^\((.+?)\)  ?([^:]+): (.+?)$/i, '(\1)  \2: \3')
      else
        gsub(/^\((.+?)\)  ?([^:]+): (.+?)$/i, '(\1)  [b]\2[/b]: \3')
      end
    end
  end
end

class String
  include LogFormatting
end
