require 'rb-readline'

guard 'bundler' do
  watch('Gemfile')
  watch('buckaroo-ideal.gemspec')
end

guard 'rspec', version: 2, cli: '--format Fuubar --colour' do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{lib/.+\.rb})        { "spec" }
  watch('spec/spec_helper.rb') { "spec" }
end

guard 'yard', stdout: '/dev/null', stderr: '/dev/null' do
  watch('README.md')
  watch(%r{lib/.+\.rb})
end
