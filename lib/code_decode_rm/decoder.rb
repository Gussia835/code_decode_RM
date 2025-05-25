# decoder.rb
require 'prime'

module CodeDecodeRM
  class Decoder
    PRIMES = [2, 3, 5, 7, 11, 13].freeze

    def decode(numbers)
      numbers.map { |num| decode_instruction(num) }
    end

    private

    def decode_instruction(number)
      return [] if number == 1

      factors = Prime.prime_division(number).to_h
      
      # Извлекаем параметры по позициям простых чисел
      params = PRIMES.map do |prime|
        exponent = factors.fetch(prime, 0) - 1
        exponent >= 0 ? exponent : nil
      end.compact

      params
    end
  end
end