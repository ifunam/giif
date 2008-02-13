class MigrationHelper < ActiveRecord::Migration
  def self.fixtures(fixtures)
    Fixtures.create_fixtures(RAILS_ROOT + '/test/fixtures', [fixtures.to_s], { fixtures.to_s => Inflector.classify(fixtures)}) if ENV['RAILS_ENV'] != 'test'
  end
end