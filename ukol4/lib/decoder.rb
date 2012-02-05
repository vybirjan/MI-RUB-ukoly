class Decoder
  
  def self.decodeChar(char, offset)
    val = char.ord - ASCII_PRINTABLE_LOW
    val = (val + offset) % (ASCII_PRINTABLE_HIGH - ASCII_PRINTABLE_LOW + 1)
    return (val + ASCII_PRINTABLE_LOW).chr 
  end
  
  def self.decodeString(string, offset)
    ret = ""
    string.each_char {|char|
      ret << decodeChar(char, offset)
    }
    return ret
  end
  
  private
  
  ASCII_PRINTABLE_LOW = 32
  ASCII_PRINTABLE_HIGH = 126
  
end