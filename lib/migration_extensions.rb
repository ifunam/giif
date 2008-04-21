require 'rubygems'
require 'active_record'
require 'active_record/fixtures'
module ActiveRecord
  class ActiveRecord::Migration
    def self.fixtures(fixtures)
      Fixtures.create_fixtures(RAILS_ROOT + '/test/fixtures', [fixtures.to_s]) if ENV['RAILS_ENV'] != 'test'
    end
  end

  class ActiveRecord::ConnectionAdapters::TableDefinition
    def references(*args)
      self 
      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      #execute "ALTER TABLE #{table_name} ADD FOREIGN KEY (#{foreign_key}) REFERENCES #{references} ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE" 
      end
    end
  end
end
