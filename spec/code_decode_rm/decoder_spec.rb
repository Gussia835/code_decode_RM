# spec/code_decode_rm/decoder_spec.rb

require 'spec_helper'
require_relative '../../lib/code_decode_rm/decoder'

RSpec.describe CodeDecodeRM::Decoder do
  let(:decoder) { described_class.new }

  describe '#decode' do
    it 'декодирует присваивание значения' do
      # 1134472500 = 2^2 * 3^3 * 5^4 * 7^5 → [1,2,3,4]
      expect(decoder.decode([1134472500])).to eq([[1, 2, 3, 4]])
    end

    it 'декодирует команду stop' do
  # 1728 = 2^6 * 3^3 → [5, 2]
  expect(decoder.decode([1728])).to eq([[5, 2]])
end

    it 'возвращает пустой массив для 1' do
      expect(decoder.decode([1])).to eq([[]])
    end

    it 'корректно обрабатывает несколько чисел' do
  input = [145800, 1728] # inc и stop
  expect(decoder.decode(input)).to eq(
    [[2, 5, 1], [5, 2]]
  )
end
  end
end