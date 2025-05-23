module CodeDecodeRM
  class Decoder
    PRIMES_CACHE = Prime.each.take(100).freeze

    def decode(number)
      return [] if number <= 1

      Prime.prime_division(number).map.with_index do |(prime, exp), i|
        decode_instruction(exp)
      end
    end

    private

    def decoode_instruction(exp)
      instruction = []
      current = exp

      [2,3,5,7,11].each do |p|
        count = 0
        while current % p == 0
          current /= p
          count += 1
        end
        instruction << count - 1 if count > 0
      end
      instruction
    end
  end
end
