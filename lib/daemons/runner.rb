# This is the script that kicks off a single CloudCrowd::Daemon. Because the 
# daemons don't load the entire rails stack, this file functions like a mini
# environment.rb, loading all the common gems that we need.

RAILS_ENV = ENV['RAILS_ENV'] || 'development' unless defined?(RAILS_ENV)
RAILS_ROOT = File.expand_path(File.dirname(__FILE__) + '/../..') unless defined?(RAILS_ROOT)

# Standard Lib and Gems
require 'rubygems'
require 'daemons'
require 'socket'
require 'yaml'
require 'json'
require 'rest_client'
require 'right_aws'

# Daemon/Worker Dependencies.
require "#{RAILS_ROOT}/lib/cloud_crowd"
Dir["#{RAILS_ROOT}/lib/cloud_crowd/*.rb"].each {|ruby| require ruby }

Daemons.run("#{RAILS_ROOT}/lib/daemons/daemon.rb", {
  :app_name   => "cloud_crowd_worker",
  :multiple   => true,
  :backtrace  => true,
  :log_output => true
})
