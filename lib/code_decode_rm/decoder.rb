require 'prime'

module CodeDecodeRM
  class Decoder
    PRIMES = [2, 3, 5, 7, 11, 13, 17].freeze # Используем 7 primes для инструкций

    def decode(numbers)
      numbers.flat_map { |num| decode_instruction(num) }
    end

    private

    def decode_instruction(number)
      return { raw: [], text: "NOP" } if number == 1

      factors = Prime.prime_division(number).to_h
      params = PRIMES.map do |prime|
        exp = factors.fetch(prime, 0) - 1
        exp >= 0 ? exp : nil
      end.compact

      instruction = expand_params(params)
      {
        raw: instruction,
        text: instruction_to_text(instruction)
      }
    end

    def expand_params(params)
      case params[0]
      when 4
        operator_code = params[3]
        operator = case operator_code
                   when 0 then '=='
                   when 1 then '!='
                   when 2 then '<'
                   when 3 then '<='
                   when 4 then '>'
                   when 5 then '>='
                   else '=='
                   end
        [4, *params[1..2], operator, *params[4..6]]
      else
        params
      end
    end

    def instruction_to_text(instr)
      return "INVALID" if instr.empty?

      case instr[0]
      when 1
        "#{instr[1]}: x#{'1' * instr[2]} <- #{instr[3]}"
      when 2
        "#{instr[1]}: x#{'1' * instr[2]} += 1"
      when 3
        "#{instr[1]}: x#{'1' * instr[2]} -= 1"
      when 4
        "#{instr[1]}: if x#{'1' * instr[2]} #{instr[3]} #{instr[4]} goto #{instr[5]} else #{instr[6]}"
      when 5
        "#{instr[1]}: STOP"
      else
        "UNKNOWN"
      end
    end
  end
end