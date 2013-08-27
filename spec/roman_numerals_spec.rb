require 'spec_helper'

def solution(roman)
  RomanDecoder.decode(roman)
end

class RomanDecoder
  def self.decode(roman)
    new(roman).decode
  end

  def initialize(roman)
    @roman = roman
  end

  def decode
    reversed = ary_translation.reverse
    sum = 0
    reversed.each_with_index do |val, index|
      next_numeral = reversed[index + 1].to_i
      if next_numeral < val
        sum += (val - next_numeral)
        reversed.slice!(index + 1)
      else
        sum += val
      end
    end
    sum
  end

  def ary_translation
    @roman.split('').map { |val| definitions[val] }
  end

  def definitions
    {
        'M' => 1000,
        'D' => 500,
        'C' => 100,
        'L' => 50,
        'X' => 10,
        'V' => 5,
        'I' => 1
    }
  end
end

describe RomanDecoder do
  specify { expect(described_class.decode('XXI')).to eq 21 }
  specify { expect(described_class.decode('I')).to eq 1 }
  specify { expect(described_class.decode('IV')).to eq 4 }
  specify { expect(described_class.decode('MMVIII')).to eq 2008 }
  specify { expect(described_class.decode('MDCLXVI')).to eq 1666 }
end
