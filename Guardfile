guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :test, :test_paths => ['test/unit', 'test/integration'] do
  watch('lib/twdeps.rb'){"test"}
  watch(%r{^lib/twdeps/(.+)\.rb$}){|m| "test/unit/test_#{m[1]}.rb"} 
  watch(%r{^test/unit/test_(.+)\.rb$})
  watch('test/test_helper.rb'){"test"}
  watch('test/helpers/**/*'){"test"}
end
