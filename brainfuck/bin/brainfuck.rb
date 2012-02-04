require_relative '../lib/brainfuck_ast.rb'
require_relative '../lib/brainfuck_interpreter.rb'
require_relative '../lib/brainfuck_parser.rb'
require_relative '../lib/bf_c_translator.rb'

def print_help
  puts "Brainfuck interpreter, arguments:"
  puts "  -help                   - prints this help"
  puts "  -i                      - start in interactive mode"
  puts "  <input file>            - parse brainfuck code from input file"
  puts "  <input file> -to_c      - optional argument, parses brainfuck code from file, converts"
  puts "                            it into C language and prints result to standard output"
  exit
end

def run_interactive
  puts "Brainfuck in ruby v 0.1, interactive console"
  puts
  puts "Type in brainfuck commands, press Enter to run"
  puts "Type 'help' for list of available commands"
  puts ""
  
  context = BrainfuckContext.new
  
  regex = /^mem (\d+)$/
  
  run = true
  while run do
    cmd = STDIN.gets.chomp
    case cmd
      when "exit"
      run = false
      when "help"
      print_interactive_help
      when "reset"
      context.reset
      puts "\nContext reset\n\n"
      when "mem"
      puts
      puts "Memory content (^ - current pointer):"
      context.print_memory
      puts
    else
      result = regex.match(cmd)
      if(result == nil)
        parser = BrainfuckParser.new
        begin
          parser.parse_code(cmd)
          ast = parser.get_start
          BrainfuckInterpreter.interpret(ast, context)
          puts "\n\nCommand executed"
        rescue BrainfuckParseError => err
          puts "Failed to parse command: " << err.message
        rescue RangeError => err
          puts "Moved outside allocated memory - " << err.message
        end
      else
        puts
        puts "Memory content around address " << result[1] << ":"
        context.print_memory(Integer(result[1]))
      end
      puts
    end
  end
  
  exit(0)
end

def print_interactive_help
  puts ""
  puts "Available commands:"
  puts "  help          - prints this help"
  puts "  exit          - closes brainfuck console"
  puts "  mem           - prints content of memory around pointer"
  puts "  mem <address> - prints content of memory around given address"
  puts "  reset         - restarts context to initital value"
end



def parse_source(source_file)
  
  begin
    ast = parse_ast_from_file(source_file)
    context = BrainfuckContext.new
    BrainfuckInterpreter.interpret(ast, context)
  rescue BrainfuckParseError => err
    puts "Parse error on line " << err.line.to_s << ", column " << err.column.to_s << " in file '" << source_file << "': " << err.message 
    exit(2)
  rescue => err
    puts "Error: " << err.message
    exit(3)
  end
  
  
  exit(0)
end

def parse_ast_from_file(file_name)
  parser = BrainfuckParser.new
  
  File.open(file_name, "r") do |infile|
    while(line = infile.gets)
      parser.parse_code(line << '\n')
    end
  end
  
  return parser.get_start
  
end

def convert_to_c(source_file)
  begin
    ast = parse_ast_from_file(source_file)
    c_source = BrainfuckCTranslator.to_c_source(ast)
    puts c_source
  rescue BrainfuckParseError => err
    puts "Parse error on line " << err.line.to_s << ", column " << err.column.to_s << " in file '" << source_file << "': " << err.message 
    exit(2)
  rescue => err
    puts "Error: " << err.message
    exit(3)
  end
  exit(0)
end

if(ARGV.empty?)
  puts "Arguments missing, for help run application with -help parameter"
  exit(1)
end

case ARGV[0]
  when "-help"
  print_help
  when "-i"
  run_interactive
else
  source_file = ARGV[0]
  if(ARGV.length == 1)
    parse_source(source_file)
  else
    if(ARGV.length == 2 and ARGV[1] == "-to_c")
      convert_to_c(source_file)
    end
  end
end

puts "Unrecognized arguments, for help run application with -help parameter"
exit(1)