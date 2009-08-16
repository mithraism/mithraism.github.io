module Nanoc3::Filters

  class SetlistToCue < Nanoc3::Filter

    identifier :setlist_to_cue

    def run(content, params={})
      cue = ''

      # Performer
      cue << 'PERFORMER ' + escape(assigns[:item][:performer]) + "\n"

      # Title
      cue << 'TITLE     ' + escape(assigns[:item][:title]) + "\n"

      # File
      filename = assigns[:item][:url][/([^\/]+)$/]
      cue << 'FILE      ' + escape(filename) + "\n"

      # Tracks
      assigns[:item][:setlist].each_with_index do |track, index|
        # Track
        cue << "  TRACK %02i AUDIO\n" % [ index+1 ]

        # Performer
        cue << '    PERFORMER ' + escape(track[:artist]) + "\n"

        # Title
        cue << '    TITLE     ' + escape(track[:title]) + "\n"

        # Index
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
