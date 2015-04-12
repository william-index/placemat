require "placemat/version"
require 'optparse'


class FileGenerator

  def output(contents, filename = "output.html")
    out_file = File.new(filename, "w")
    out_file.puts(contents)
    out_file.close
  end

end

require "placemat/PlmatToHTML_Converter"
require "placemat/OptionParser"
