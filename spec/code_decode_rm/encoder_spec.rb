# spec/code_decode_rm/encoder_spec.rb

require 'spec_helper'
require_relative '../../lib/code_decode_rm/encoder'

RSpec.describe CodeDecodeRM::Encoder do
  let(:encoder) { described_class.new }

  describe '#encode' do
    it 'кодирует присваивание значения' do
      # [1, label, reg, value] → 2^(1+1) * 3^(label+1) * 5^(reg+1) * 7^(value+1)
      # [1, 2, 3, 4] → 2^2 * 3^3 * 5^4 * 7^5 = 4 * 27 * 625 * 16807 = 1134472500
      expect(encoder.encode([[1, 2, 3, 4]])).to eq([1134472500])
    end

    it 'кодирует инкремент регистра' do
      # [2, label, reg] → 2^(2+1) * 3^(label+1) * 5^(reg+1)
      # [2, 5, 1] → 2^3 * 3^6 * 5^2 = 8 * 729 * 25 = 145800
      expect(encoder.encode([[2, 5, 1]])).to eq([145800])
    end

    it 'кодирует несколько инструкций' do
      instructions = [
        [1, 1, 1, 3], # assign x1 <- 3
        [5, 2]        # stop
      ]
      expect(encoder.encode(instructions)).to eq([2**2 * 3**2 * 5**2 * 7**4, 2**6 * 3**3])
    end
  end
end