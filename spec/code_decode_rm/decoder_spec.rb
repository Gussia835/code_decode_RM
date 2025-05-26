require 'spec_helper'
require_relative '../../lib/code_decode_rm/decoder'

RSpec.describe CodeDecodeRM::Decoder do
  let(:decoder) { described_class.new }

  describe '#decode' do
    it 'декодирует присваивание значения' do
      expect(decoder.decode([1134472500])).to eq([{:raw=>[1, 2, 3, 4], :text=>"2: x111 <- 4"}])
    end

    it 'декодирует команду stop' do
      expect(decoder.decode([1728])).to eq([{:raw=>[5, 2], :text=>"2: STOP"}])
    end

    it 'возвращает пустой массив для 1' do
      expect(decoder.decode([1])).to eq([{:raw=>[], :text=>"NOP"}])
    end

    it 'корректно обрабатывает несколько чисел' do
      input = [145800, 1728] # inc и stop
      expect(decoder.decode(input)).to eq([{:raw=>[2, 5, 1], :text=>"5: x1 += 1"}, {:raw=>[5, 2], :text=>"2: STOP"}])
    end
  end
end
