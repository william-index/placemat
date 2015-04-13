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

    plmat_string = strip_full_line_comments(plmat_string)
    plmat_string = split_apart_tables(plmat_string)
    plmat_string = split_rows(plmat_string)

    base_file_name = plmat.slice(0..(plmat.index('.')-1))
    generator.output(plmat_string, base_file_name+".html")
  end

  private

  ##
  # Splits the content of a .plmat file into an
  # array of strings, one string for each table
  #
  # Tables are delimited via an empty line
  #
  # Arguments:
  #   raw_data: (String) - string of raw .plmat format data
  #
  # Returns:
  #   (Array) - Array of strings of raw table data
  def split_apart_tables(raw_data) #:doc:
    raw_data.split(/\n\n/)
  end

  ##
  # Splits a table intro two sections for header content
  # and body content based on a line of pure hyphens
  #
  # Any line beginning with spaces or tabs becomes a part of the previous line
  #
  # Splits Each content section by line break into rows
  #
  # Arguments:
  #   raw_table_data
  #
  # Returns:
  #   (Array) - multi-dimensional array of table header rows and body rows
  def split_rows(raw_table_data) #:doc:
    tables_with_rows = Array.new
    raw_table_data.each_with_index do |table, i|
      table_rows = Array.new
      table = table.gsub(/\n+^[\t|\s|\s\s|\t\s]/,"")
      table = table.split(/^[-]+$/)
      table.each_with_index do |sect, i|
        table[i] = sect.split(/\n/)
      end
      tables_with_rows[i] = table
    end
    tables_with_rows
  end

  ##
  # Strips out any lines beginning with a semi-colon
  # from the each line fo the document
  #
  # Arguments:
  #   raw_table_data (Array) - raw table data from plmat file
  #
  # Returns:
  #   (Array) - input array but without child strings that started with ";"
  def strip_full_line_comments(raw_table_data) #:doc:
    raw_table_data = raw_table_data.split(/\n/)
    raw_table_data.each_with_index do |row, i|
      if row[0,1] == ";"
        raw_table_data.delete_at(i)
      else
        raw_table_data[i] = trim_same_line_comments(row)
      end
    end
    raw_table_data.join("\n")
  end

  ##
  # Removes in-line comments from end of lines
  # Any content after a semi-colon will be removes
  #
  # Arguments:
  #  row (String) - contents of a single row
  def trim_same_line_comments(row) #:doc:
    comment_index = row.index(';')
    if comment_index
      row = row[0,comment_index]
    end
    row
  end

end
