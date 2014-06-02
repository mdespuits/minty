require 'spec_helper'

describe Minty::Utils do

  VALUE_MAP = {
    "2.45"      => "$ 2.45",
    "245"       => "$ 245.00",
    "24.5"      => "$ 24.50",
    "24000.500" => "$ 24000.50",
  }

  describe '#dollars' do
    it 'should convert values properly' do
      VALUE_MAP.each do |original, formatted|
        expect(Minty::Utils.dollars(original)).to eq formatted
      end
    end
  end
end
