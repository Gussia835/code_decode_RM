module CodeDecodeRM
  class Parser
    INSTRUCTION_REGEX = {
      assign: /(\d+):\s*([xX]1+)\s*<-\s*(\d+)/,
      inc:    /(\d+):\s*([xX]1+)\s*<-\s*\2\s*\+\s*1/,
      dec:    /(\d+):\s*([xX]1+)\s*<-\s*\2\s*-\s*1/,
      cond:   /(\d+):\s*if\s+([xX]1+)\s*(<=|<|>|>=|=|!=)\s*(\d+)\s*goto\s+(\d+)\s+else\s+goto\s+(\d+)/,
      stop:   /(\d+):\s*stop/
    }.freeze

    def parse(input)
      input.lines.map { |line| parse_line(line.strip) }.compact
    end

    private

    def parse_line(input)
      if input.match?(/[xX][^1]/)
        raise ArgumentError, "Invalid register format"
      end
      
      case input
      when INSTRUCTION_REGEX[:assign] then parse_assign($1, $2, $3)
      when INSTRUCTION_REGEX[:inc]    then parse_inc($1, $2)
      when INSTRUCTION_REGEX[:dec]    then parse_dec($1, $2)
      when INSTRUCTION_REGEX[:cond]   then parse_cond($1, $2, $3, $4, $5, $6)
      when INSTRUCTION_REGEX[:stop]   then parse_stop($1)
      else
        raise ArgumentError, "Invalid instruction: #{input}"
      end
    rescue ArgumentError => e
      raise e # Пробрасываем уже обработанные ошибки регистра
    end
  
    def register_to_index(reg)
      reg.match(/^x(1+)$/i)[1].size
    rescue
      raise ArgumentError, "Invalid register format: #{reg}"
    end

    def parse_assign(label, reg, value)
      [1, label.to_i, register_to_index(reg), value.to_i]
    end

    def parse_inc(label, reg)
      [2, label.to_i, register_to_index(reg)]
    end

    def parse_dec(label, reg)
      [3, label.to_i, register_to_index(reg)]
    end

    def parse_cond(label, reg, operator, value, true_label, false_label)
      operator = "==" if operator == "="
      [
        4,
        label.to_i,
        register_to_index(reg),
        operator,
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
