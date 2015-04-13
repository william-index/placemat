##
# The Class used for parsing and converstion of .plmat to .html
class PlmatToHTML_Converter

  ##
  # Gets contents of a .plmat file, calls methods to
  # parse and reformat into valid html5, and saves out
  # the new content into a .html file
  #
  # Example:
  #   >> PlmatToHTML_Converter.complile(filename.plmat)
  #   => filename.html
  #
  # Arguments:
  #   * plmat: (File)
  #
  # Returns:
  #   * (.html File)
  def compile(plmat)
    generator = FileHandler.new
    plmat_string = generator.content(plmat)

    # TODO parse out entire file, haha

    base_file_name = plmat.slice(0..(plmat.index('.')-1))
    generator.output(plmat_string, base_file_name+".html")
  end

  private

end
