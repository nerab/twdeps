guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :test do
  watch(%r{^lib/(.+)\.rb$}){|m| "test/#{m[1]}_test.rb"}
  watch(%r{^test/unit/test_(.+)\.rb$})
  watch('test/test_helper.rb'){"test"}
  watch('test/helpers/**/*'){"test"}
end
