require 'active_record'
require 'active_record/fixtures'
module ActiveRecord

  class ActiveRecord::Migration
    def self.fixtures(fixtures)
      Fixtures.create_fixtures(RAILS_ROOT + '/test/fixtures', [fixtures.to_s]) if ENV['RAILS_ENV'] != 'test'
    end
  end

  module ConnectionAdapters

    module SchemaStatements
      def create_table(table_name, options = {})
        table_definition = TableDefinition.new(self)
        table_definition.primary_key(options[:primary_key] || "id") unless options[:id] == false

        yield table_definition

        if options[:force]
          drop_table(table_name, options) rescue nil
        end

        create_sql = "CREATE#{' TEMPORARY' if options[:temporary]} TABLE "
        create_sql << "#{quote_table_name(table_name)} ("
        create_sql << table_definition.to_sql
        create_sql << ") #{options[:options]}"
        execute create_sql

        table_definition.reference_keys.keys.each do |table|
          if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
            execute "ALTER TABLE #{quote_table_name(table_name)} ADD FOREIGN KEY (#{table_definition.reference_keys[table]}) REFERENCES #{table} ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE"
          end
        end
      end
    end
 
    class TableDefinition
      attr_accessor :reference_keys

      def initialize(base)
        @columns = []
        @base = base
        @reference_keys = {}
      end

      def references(*args)
        options = args.extract_options!
        polymorphic = options.delete(:polymorphic)
        args.each do |col|
          if options[:null] == false
            table = options[:class_name] ? Inflector.tableize(options[:class_name]) : Inflector.tableize(col)
            foreign_key = options[:foreign_key] ? options[:foreign_key] : "#{col}_id"
            @reference_keys[table] = foreign_key
          end
          column("#{col}_id", :integer, options)
          unless polymorphic.nil?
            column("#{col}_type", :string, polymorphic.is_a?(Hash) ? polymorphic : {})
          end
        end
      end
    end
    
  end

end
