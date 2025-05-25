require 'prime'

module CodeDecodeRM
  class Encoder
    PRIMES = [2, 3, 5, 7, 11, 13].freeze

    def encode(instructions)
      instructions.map { |instr| encode_instruction(instr) }
    end

    private

    def encode_instruction(instr)
      instr.each_with_index.inject(1) do |product, (value, idx)|
        prime = PRIMES[idx] || next
        exponent = value.negative? ? 0 : value + 1
        product * (prime ** exponent)
      end
    end
  end
end