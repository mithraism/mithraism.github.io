module Nanoc3::Filters

  class SetlistToCue < Nanoc3::Filter

    identifier :setlist_to_cue

    def run(content, params={})
      cue = ''

      # General details
      cue << 'PERFORMER ' + escape(assigns[:item][:performer]) + "\n"
      cue << 'TITLE     ' + escape(assigns[:item][:title]) + "\n"
      cue << 'FILE      ' + escape(assigns[:item][:url][/([^\/]+)$/]) + "\n"

      # Tracks
      assigns[:item][:setlist].each_with_index do |track, index|
        cue << "  TRACK %02i AUDIO\n" % [ index+1 ]

        cue << '    PERFORMER ' + escape(track[:artist]) + "\n"
        cue << '    TITLE     ' + escape(track[:title]) + "\n"
        cue << '    INDEX 01  ' + track[:from] + ':00' + "\n"
      end

      cue
    end

  private

    def escape(s)
      '"' + s.gsub('"', '\\"') + '"'
    end

  end

end
