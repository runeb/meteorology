module Meteorology
  module Providers
  end
end

Dir[File.dirname(__FILE__) + '/providers/*.rb'].each{|g| require g}
