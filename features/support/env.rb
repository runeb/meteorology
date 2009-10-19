$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'meteorology'

require 'spec/expectations'

require "spec/mocks"

Before do
  $rspec_mocks ||= Spec::Mocks::Space.new
end

After do
  begin
    $rspec_mocks.verify_all
  ensure
    $rspec_mocks.reset_all
  end
end
