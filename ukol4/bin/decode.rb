require_relative '../lib/decoder.rb'

DEFAULT_OFFSET = -7

offset = DEFAULT_OFFSET
if(ARGV.length == 1)
  begin
    offset = Integer(ARGV[0])
  rescue ArgumentError
  end
end

while((line = STDIN.gets) != nil)
  puts Decoder.decodeString(line.chomp, offset)
end