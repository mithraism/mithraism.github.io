task :compile_stylesheet do
  puts '*** COMPILING STYLESHEET'
  Dir["assets/*.css"].each do |path|
    definitions = {}

    # Read CSS file
    css = File.read(path)

    # Convert CSS
    new_css = css.inject([]) do |lines, line|
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

    # Write new CSS
    File.open(path.sub(/^assets\//, 'output/media/style/'), 'w') do |io|
      io.write(new_css.sub(/^[\s\n\r]+/, ''))
    end
  end
end

task :compile => :compile_stylesheet do
  puts '*** COMPILING SITE'
  system('nanoc co')
end

task :default => :compile
