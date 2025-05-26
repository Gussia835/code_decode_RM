require "spec_helper"

RSpec.describe "Integration" do
  let(:parser) { CodeDecodeRM::Parser.new }
  let(:encoder) { CodeDecodeRM::Encoder.new }
  let(:decoder) { CodeDecodeRM::Decoder.new }

  it "полный цикл: парсинг → кодирование → декодирование" do
    input = <<~PROG
      1: x1 <- 5
      2: x11 <- x11+1
      3: if x1 = 10 goto 5 else goto 4
      4: stop
    PROG

    program = parser.parse(input)
    encoded = encoder.encode(program)
    decoded = decoder.decode(encoded)

    expect(decoded).to eq([{:raw=>[1, 1, 1, 5], :text=>"1: x1 <- 5"}, {:raw=>[2, 2, 2], :text=>"2: x11 += 1"}, {:raw=>[4, 3, 1, "==", 10, 5, 4], :text=>"3: if x1 == 10 goto 5 else 4"}, {:raw=>[5, 4], :text=>"4: STOP"}])
  end
end
