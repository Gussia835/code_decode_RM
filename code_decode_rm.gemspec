require File.expand_path("lib/code_decode_rm/version", __dir__)
Gem::Specification.new do |spec|
  spec.name = 'code_decode_RM'
  spec.version = CodeDecodeRM::VERSION
  spec.authors = ['Dmitriy Fedotov']
  spec.email = ['fdtvdmitriy@gmail.com']
  spec.summary = 'code and decode Registry machines'
  spec.description = 'allows to encode and decode register machines'
  spec.homepage = 'https://github.com/Gussia835/code_decode_RM.git'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'


spec.files = Dir['README.md', 'LICENSE.md',
                  'CHANGELOG.md', 'lib/**/*.rb',
                  'lib/**/*.rake',
                  '.github/*.md',
                  'Rakefile']

spec.extra_rdoc_files = ['README.md']

spec.add_dependency "prime"

spec.add_dependency "base64"

spec.add_development_dependency "rspec", "~> 3.0"
spec.add_development_dependency "rubocop", "~> 1.63"
spec.add_development_dependency "rubocop-performance"
spec.add_development_dependency "rubocop-rspec", "~> 2.0"

spec.executables = ["code_decode_rm"]

end