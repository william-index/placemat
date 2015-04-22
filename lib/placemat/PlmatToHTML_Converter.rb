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
    plmat_string = format_rows(plmat_string)

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
      if row.first == ";"
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

  ##
  # Handles call for all formatting of contents within any given row
  #
  # Arguments:
  #   tables (Array) - array containing all table data
  #
  # Returns:
  #   (String) - full formatted html table contents
  def format_rows(tables) #:doc:
    tables.each_with_index do |sections, i|
      sections = format_sections(sections)
      tables[i] = build_table(sections)
    end
    tables
  end

  ##
  # Formats each section of a table by wrapping cells
  # and rows with appropraite tags
  # This trickles through formatting, for all deeper levels as well
  #
  # Arguments:
  #   sections (Array) - array of sections, where each section is an array of rows
  #
  # Returns:
  #   (Array) - array fo strings, one string per section
  def format_sections(sections) #:doc:
    tag_array = ["th","td"]
    if sections.length == 1
      tag_array = ["td"]
    end
    sections.each_with_index do |section, i|
      section.each_with_index do |row, j|
        cells = row.split("|")
        cells.each_with_index do |cell, k|
          cells[k] = format_cell(cell, tag_array[i])
        end
        sections[i][j] = wrap_row(cells)
      end
    end
    sections
  end

  ##
  # Joins cells into single string and wraps in row tag
  #
  # Arguments:
  #   cells (Array)
  def wrap_row(cells) #:doc:
    if cells.length > 0
      "\t<tr> "+cells.join("")+ " </tr>"
    end
  end

  ##
  # Finalizes formatting on the cell level
  # This also parses out the plmat attributes to be passed
  # to the attribtue formatter (build_cell_attrs)
  #
  # If the X attribute is set however the cell will not be
  # rendered
  #
  # Arguments:
  #   cell (String) - raw contents of a cell
  #   tag (String)  - html tag to use for cell
  def format_cell(cell, tag="td") #:doc:
    raw_cell = cell.strip
    cell_parts = raw_cell.split("::")
    attr_args = cell_parts.fetch(1,"").split("&")

    if attr_args.include? "X"
      ""
    else
      attrs = build_cell_attrs(attr_args)
      "<#{tag}#{attrs}>#{cell_parts[0]}</#{tag}>"
    end
  end

  ##
  # Builds tag attributes for a cell based on passed arguments
  # If a value to value key code is present, it builds based on
  #   values in the local attr_keys hash, if not if checks for
  #   more complex intructions and passes to the appropriate method
  #
  # Arguments:
  #   args (Array) - all arguments passed from the .plmat argument block
  #
  # Returns:
  #   (String) - string of formatted html attributes
  def build_cell_attrs(args) #:doc:
    attrs = " "
    attr_keys = Hash["r"=>"rowspan", "c"=>"colspan"]

    args.each do |arg|
      if attr_keys.has_key?(arg.first)
        attrs += attr_keys[arg.first] + '="' + arg[1,arg.length] + '" '
      else
        attrs += parse_selectors(arg)
      end
    end
    attrs
  end

  ##
  # Parses a css-like selector string of class(es) and optionally
  #   an id (or ids? but don't do that) into their appropriate attribute strings
  #
  # Arguments:
  #   sel_str (String) - selector string
  def parse_selectors(sel_str) #:doc:
    classes = Array.new
    ids     = Array.new
    attr_str= ""

    sel_str = sel_str.gsub(/[\.\#]/, "." => "-.", "#" => "-#")
    sel_str = sel_str[1,sel_str.length].split("-")

    sel_str.each do |str|
      if str.first == "."
        classes.push(str.trim_first)
      else
        ids.push(str.trim_first)
      end
    end

    if classes.length > 0
      attr_str += 'class="' + classes.join(" ") + '" '
    end
    if ids.length > 0
      attr_str += 'id="' + ids.join(" ") + '" '
    end

    attr_str
  end

  ##
  # Combines sections and wraps sections in a table tag
  #
  # Arguments:
  #   sections (Array) - @see return format_section
  #
  def build_table(sections) #:doc:
    "<table>\n"+sections.join("\n")+"\n</table>\n\n"
  end
end
