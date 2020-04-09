require "./processor"

filename = ARGV[0]
buffer_name = ARGV[1]

begin
  puts SafeECR.process_file(filename, buffer_name)
rescue ex : File::Error
  STDERR.puts ex.message
  exit 1
end
