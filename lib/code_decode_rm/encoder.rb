require 'prime'

module CodeDecodeRM
  class Encoder
    PRIMES = [2, 3, 5, 7, 11, 13, 17].freeze

    def encode(instructions)
      instructions.map { |instr| encode_instruction(instr) }
    end

    private

    def encode_instruction(instr)
      return nil if instr.empty?

      # Преобразуем оператор условия в числовой код
      if instr[0] == 4
        operator = instr[3]
        operator_code = case operator
                        when '==' then 0
                        when '!=' then 1
                        when '<' then 2
                        when '<=' then 3
                        when '>' then 4
                        when '>=' then 5
                        else 0
                        end
        instr = [4, instr[1], instr[2], operator_code, instr[4], instr[5], instr[6]]
      end

      instr.each_with_index.inject(1) do |product, (value, idx)|
        prime = PRIMES[idx] or next
        exponent = value.respond_to?(:to_i) ? value.to_i + 1 : 1
        product * (prime ** exponent)
      end
    end
  end
end