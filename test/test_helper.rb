require 'rubygems'
require 'test/unit'
require 'active_support'
require 'action_mailer'

$:.push File.expand_path("../../lib", __FILE__)
require File.dirname(__FILE__) + '/../lib/seatbelt.rb'

# Requiring custom spec helpers
Dir[File.dirname(__FILE__) + "/helpers/**/*.rb"].sort.each { |f| require File.expand_path(f) }
