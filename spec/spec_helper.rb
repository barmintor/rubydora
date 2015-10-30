$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

if ENV['COVERAGE'] && RUBY_VERSION =~ /^1.9/
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
end

require 'rspec/autorun'
require 'rubydora'
require 'webmock/rspec'

WebMock.allow_net_connect!

RSpec.configure do |config|
end
