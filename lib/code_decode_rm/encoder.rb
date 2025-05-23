module CodeDecodeRM
  class Encoder
    PRIMES_CACHE = Prime.each.take(100).freeze

    def encode(instructions)
      instructions.each_with_index.inject(1) do |product, (instr, i)|
        product * (PRIMES_CACHE[i] ** encode_instruction(instr))
      end
    end

    private

    def encode_instruction(instr)
      primes = [2, 3, 5, 7, 11]
      instr.each_with_index.inject(1) do |product, (value, idx)|
        product * (primes[idx] ** (value + 1))
      end
    end
  end
end