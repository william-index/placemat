require "placemat/version"
require 'optparse'

##
# Handles the Reading and writing of files
class FileHandler

  ##
  # Retrieves the content as text of a file
  #
  # Arguments:
  #   * plmat (File) - a .plmat file in .plmat markdown
  #
  # Return:
  #   * (String) - contents of .plmat file
  def content(plmat)
    file = File.open(plmat, "rb")
    file.read
  end

  ##
  # Creates or overwrites text to a new file
  #
  # Arguments:
  #   * contents (String) - string of text to write to file
  #   * filename (String) - name for new file, defaults to output.html if not specified
  def output(contents, filename = "output.html")
    out_file = File.new(filename, "w")
    out_file.puts(contents)
    out_file.close
  end

end

##
# Extends the String open class to allow quick retrieval of the first character
#
# @see http://stackoverflow.com/questions/2730854/ruby-how-to-get-the-first-character-of-a-string
class String #:nodoc:
  def first #:nodoc:
    self[0,1]
  end
  def trim_first #:nodoc:
    self[1,self.length]
  end
end



require "placemat/PlmatToHTML_Converter"
require "placemat/OptionParser"
