$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'meteorology'

require 'spec/autorun'

require 'fakeweb'

Spec::Runner.configure do |config|
  
end

$fixture_dir = File.join(File.dirname(__FILE__), '..', 'fixtures')
