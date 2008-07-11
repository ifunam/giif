ENV["RAILS_ENV"] = "development"
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'yaml'
require 'active_record'
require 'active_record/fixtures'
namespace :db do
  desc "Load catalogs from fixtures into current environment"
  task "catalogs:load" do
    %w(userstatuses users countries states cities addresstypes degrees 
    institutions careers documents periods).each do |fixture|
      Fixtures.create_fixtures(RAILS_ROOT + '/test/fixtures', [fixture.to_s]) if ENV['RAILS_ENV'] != 'test'
    end
   end
end
