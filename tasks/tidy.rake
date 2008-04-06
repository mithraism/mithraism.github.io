begin ; require 'rubygems' ; rescue LoadError ; end
require 'tidy'

desc 'validates all HTML files in the output directory'
task :tidy do
  # config
  show_warnings = true
  Tidy.path     = '/usr/lib/libtidy.dylib'
  ignores       = [ /Warning: replacing invalid character code/ ]

  # load site
  site = Nanoc::Site.from_cwd
  site.load_data

  # validate
  html_pages = site.pages.map { |page| page.path_on_filesystem }.reject { |path| path !~ /\.html$/ }
  errors = html_pages.inject({}) do |memo, filename|
    Tidy.open(:show_warnings => show_warnings) do |tidy|
      if File.file?(filename)
        # tidy
        tidy.clean(File.read(filename))
      
        # clean list of errors
        file_errors = tidy.errors
        file_errors = file_errors.empty? ? [] : file_errors[0].split(/\n/)
      
        # add errors to list
        memo.merge(filename => file_errors)
      else
        puts "Warning: #{filename} is not present, did you forget to compile?"
        memo
      end
    end
  end

  # dislay result
  if errors.values.flatten.empty?
    puts 'No errors.'
  else
    # get errors per file
    errors.each_pair do |filename, file_errors|
      # ignore irrelevant errors
      file_errors.reject! { |error| ignores.any? { |ignore| error =~ ignore } }

      # print errors
      unless file_errors.empty?
        puts "#{filename}:"
        puts file_errors.map { |e| '  ' + e }.join("\n")
        puts
      end
    end
  end
end
