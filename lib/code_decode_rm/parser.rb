module CodeDecodeRM
  class Parser
    REGISTER_PATTERN = /([A-Za-z])(1*)/i
    INSTRUCTION_REGEX = {
      assign: /(\d+):\s*([A-Za-z]1*)\s*<=\s*(-?\d+)/,
      inc: /(\d+):\s*([A-Za-z]1*)\s*<=\s*\w+\+1/,
      dec: /(\d+):\s*([A-Za-z]1*)\s*<=\s*\w+-1/,
      cond: /(\d+):\s*if\s+([A-Za-z]1*)\s*(<|>|<=|>=|=|!=)\s*(-?\d+)\s+goto\s+(\d+)\s+else\s+goto\s+(\d+)/,
      stop: /(\d+):\s*stop/
    }.freeze

    def parse(input)
      input.lines.map { |line| parse_line(line.strip) }
    end

    private

    def parse_line(input)
      case input
      when INSTRUCTION_REGEX[:assign] then parse_assign($1, $2, $3)
      when INSTRUCTION_REGEX[:inc] then parse_inc($1, $2)
      when INSTRUCTION_REGEX[:dec] then parse_dec($1, $2)
      when INSTRUCTION_REGEX[:cond] then parse_cond($1, $2, $3, $4, $5, $6)
      when INSTRUCTION_REGEX[:stop] then parse_stop($1)
      end
    end

    def normalize_register(reg)
      match = reg.match(REGISTER_PATTERN)
      raise ArgumentError, "Invalid register format: #{reg}" unless match

      letter = match[1].upcase
      ones = match[2].size
      index = letter.ord - 'A'.ord + 1
      "X#{'1' * (index + ones - 1)}"
    end

    def parse_assign(label, reg, value)
      [1, label.to_i, normalize_register(reg), value.to_i]
    end

    def parse_inc(label, reg)
      [2, label.to_i, normalize_register(reg)]
    end

    def parse_dec(label, reg)
      [3, label.to_i, normalize_register(reg)]
    end

    def parse_cond(label, reg, operator, value, true_label, false_label)
      [
        4,
        label.to_i,
        normalize_register(reg),
        operator.to_sym,
        value.to_i,
        true_label.to_i,
        false_label.to_i
      ]
    end

    def parse_stop(label)
      [5, label.to_i]
    end
  end
end