require "bundler/setup"
require "code_decode_rm"
require "simplecov"
SimpleCov.start
RSpec.configure do |config|
  # Отключает вывод подробной информации о тестах
  config.formatter = :documentation 
  # Фильтрация тестов (например, только тесты с `focus: true`)
  config.filter_run_when_matching :focus
end