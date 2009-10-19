require 'rubygems'
require 'libxml'
require 'time'
require 'uri'
require 'net/http'

require 'meteorology/weather_collection'
require 'meteorology/weather'
require 'meteorology/temperature'
require 'meteorology/providers'

module Meteorology
  def self.included(klass)
    klass.send(:include, InstanceMethods)
  end
  
  module InstanceMethods
    def weather
      # Just assumes #latitude and #longitude for now
      # Also just assumes Yr.no
      @weather ||= Meteorology::Providers::Yr.new.load(latitude, longitude)
    end
  end
end
