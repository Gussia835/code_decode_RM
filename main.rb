require_relative 'lib/code_decode_rm/decoder'
require_relative 'lib/code_decode_rm/encoder'
require_relative 'lib/code_decode_rm/parser'

mode = ARGV.shift

case mode

  when "encode"
     puts "Введите команды (для завершения введите строку с 'stop'):"
     input_lines = []
  
  
    while (line = $stdin.gets)
      line.chomp!
      input_lines << line
      break if line.match?(/^\d+:\s*stop/i)
    end
    parser = CodeDecodeRM::Parser.new
    encoder = CodeDecodeRM::Encoder.new

    begin
      parsed = parser.parse(input_lines.join("\n"))
      encoded = encoder.encode(parsed)
      puts 'Результат кодирования: '
      puts encoded.join(' ')
      rescue => e
        puts "Ошибка: #{e.message}"
    end

  when 'decode'
     numbers = ARGV.map(&:to_i)
  decoder = CodeDecodeRM::Decoder.new
  results = decoder.decode(numbers)
  
  results.each do |result|
    puts "Raw: #{result[:raw].inspect}"
    puts "Command: #{result[:text]}"
    puts "-" * 40
  end
  else

    puts <<~HELP
      Использование:
        Кодирование: ruby main.rb encode
        Декодирование: ruby main.rb decode <числа через пробел>

      Примеры:
        Кодирование:
          ruby main.rb encode
          1:x1 <- 5
          2:x1 <- x1+1
          Результат: 22500 145800

        Декодирование:
          ruby main.rb decode 22500 145800
          Результат: [[1, 1, 1, 5], [2, 2, 1]]
    HELP
end