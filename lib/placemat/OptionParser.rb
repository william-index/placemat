hash_options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: your_app [options]"
  opts.on('-c [ARG]', '--compile [ARG]', "Specify a .plmat file to compile") do |plmat|
    plmat_parser = PlmatToHTML_Converter.new
    plmat_parser.compile(plmat)
  end
  opts.on('--version', 'Display the version') do
    puts "0.2.0"
    exit
  end
  opts.on('-h', '--help', 'Display this help') do
    puts opts
    exit
  end
end.parse!
