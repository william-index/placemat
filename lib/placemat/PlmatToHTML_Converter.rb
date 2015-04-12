# TODO clean up all this formatting and use prooper naming conventions
# TODO pass file name to class and then get contents
# TODO output file should use same name as the input
# Parse order of operations should probably be
#   remove all comments
#   pull up tabbed lines
#   split apart multple tables
#   * for each table
#     split into rows
#     remove trailing whitespace from
#     split into cells
#     * for each cell
#       pull out arguments
#       remove trailing spaces
#       apply arguments

class PlmatToHTML_Converter
  def compile(plmat)
    file = File.open(plmat, "rb")
    contents = file.read
    generator = FileGenerator.new
    plmat = plmat.slice(0..(plmat.index('.')-1))
    generator.output(contents, plmat+".html")
  end
end
