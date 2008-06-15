module Nanoc::BinaryFilters

  class WebsiteThumbnail < Nanoc::BinaryFilter

    identifier :website_thumbnail

    def run(file)
      require 'image_science'

      # Get temporary file path
      tmp_file = Tempfile.new('filter')
      tmp_path = tmp_file.path
      tmp_file.close

      # Create thumbnail
      ImageScience.with_image(file.path) do |img|
        img.resize(img.width/1.5, img.height/1.5) do |img|
          img.with_crop(0, 0, 500, 500) do |img|
            img.save(tmp_path)
          end
        end
      end

      # Return thumbnail file
      File.open(tmp_path)
    end

  end

end
