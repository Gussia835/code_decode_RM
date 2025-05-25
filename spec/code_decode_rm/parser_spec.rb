# spec/code_decode_rm/parser_spec.rb

require 'spec_helper'
require_relative '../../lib/code_decode_rm/parser'

RSpec.describe CodeDecodeRM::Parser do
  let(:parser) { described_class.new }

  describe '#parse' do
    context 'корректные команды' do
      it 'парсит присваивание значения регистру' do
        input = "1:x11 <- 5"
        expect(parser.parse(input)).to eq([[1, 1, 2, 5]])
      end

      it 'парсит инкремент регистра' do
        input = "2:x1 <- x1+1"
        expect(parser.parse(input)).to eq([[2, 2, 1]])
      end

      it 'парсит декремент регистра' do
        input = "3:x111 <- x111-1"
        expect(parser.parse(input)).to eq([[3, 3, 3]])
      end

      it 'парсит условный переход' do
        input = "4:if x1 = x11 goto 5 else goto 6"
        expect(parser.parse(input)).to eq([[4, 4, 1, 2, 5, 6]])
      end

      it 'парсит команду stop' do
        input = "5:stop"
        expect(parser.parse(input)).to eq([[5, 5]])
      end
    end

    context 'ошибки формата' do
      it 'выбрасывает ошибку при некорректном регистре' do
        input = "6:x2 <- 3"
        expect { parser.parse(input) }.to raise_error(ArgumentError, /Invalid register format/)
      end

      it 'выбрасывает ошибку при неизвестной команде' do
        input = "7:invalid_command"
        expect { parser.parse(input) }.to raise_error(ArgumentError, /Invalid instruction/)
      end
    end
  end
end