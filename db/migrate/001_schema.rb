require RAILS_ROOT + '/db/migrate/migration_helper'
class Schema < MigrationHelper
  def self.up
    create_table :users  do |t|
      t.string  :login, :null => false
      t.string  :password, :null => false
      t.boolean :status, :null => false
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :groups do |t|
      t.string   :name, :null => false
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end
#    fixtures :groups

    create_table :user_groups do |t|
      t.integer :user_id, :null => false
      t.integer :group_id, :null => false
      t.integer :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :products do |t|
      t.integer  :product_type_id, :null => false
      t.string   :model, :null => false
      t.string   :vendor, :null => false
      t.integer  :inventory_number
      t.string   :serial_number
      t.string   :description
      t.integer  :ip_adress
      t.integer  :mac_adress
      t.integer  :speed
      t.integer  :wired
      t.integer :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
    end

    create_table :product_types do |t|
      t.string   :name, :null => false
      t.integer  :product_category_id, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :product_categories do |t|
      t.string   :name, :null => false
      t.integer :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :features do |t|
      t.string   :name
      t.integer :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
    end

    create_table :products_features do |t|
      t.integer   :product_id, :null => false
      t.integer   :feature_id, :null => false
      t.text      :description, :null => false
      t.integer   :moduser_id
      t.datetime  :created_on
      t.datetime  :updated_on
    end

    create_table :orders do |t|
      t.integer  :amount, :null => false
      t.integer  :price, :null => false
      t.integer  :folio, :null => false
      t.text     :description, :null => false
      t.string   :provider_id, :null => false
      t.boolean  :status, :null => false, :default => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :providers do |t|
      t.string   :name, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :rooms do |t|
      t.integer  :building_id, :null => false
      t.integer  :room_type_id, :null => false
      t.string   :number
      t.string   :floor
      t.string   :name
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :room_types do |t|
      t.string   :name, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :buildings do |t|
      t.string   :name, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    #Categorías: Investigadores, Personal de Confianza, Técnicos Académicos, Visitantes y Estudiantes se comunica con la plataforma de info curricular
    #Grupos: Default, Administrador, Capturista Propiedad del sistema
end

  def self.down
     drop_table :users, :groups, :user_groups, :products, :product_types, :product_groups, :features, :product_features, :orders, :providers, :buildings, :rooms, :room_types
  end
end




