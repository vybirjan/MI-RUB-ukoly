require_relative '../lib/decoder.rb'
require 'test/unit'

class DecoderTest <  Test::Unit::TestCase
  
  def test_simple
    assert_equal('B', Decoder.decodeChar('A', 1))
    assert_equal('<', Decoder.decodeChar('(', 20))
  end
  
  def test_overlapping
    assert_equal(' ', Decoder.decodeChar('~', 1))
  end
  
  def test_string
    assert_equal("*CDC is the trademark of the Control Data Corporation.", Decoder.decodeString("1JKJ'pz'{ol'{yhklthyr'vm'{ol'Jvu{yvs'Kh{h'Jvywvyh{pvu5", -7))
    assert_equal("*IBM is a trademark of the International Business Machine Corporation.", Decoder.decodeString("1PIT'pz'h'{yhklthyr'vm'{ol'Pu{lyuh{pvuhs'I|zpulzz'Thjopul'Jvywvyh{pvu5", -7))
    assert_equal("*DEC is the trademark of the Digital Equipment Corporation.", Decoder.decodeString("1KLJ'pz'{ol'{yhklthyr'vm'{ol'Kpnp{hs'Lx|pwtlu{'Jvywvyh{pvu5", -7))
  end
  
  
end