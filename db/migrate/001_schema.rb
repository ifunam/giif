class Schema   < ActiveRecord::Migration
  def self.up
    create_table :users  do |t|
      t.string  :login, :null => false
      t.string  :email, :null => false
      t.string  :password, :null => false
      t.string  :salt, :null => false
      t.boolean :status, :null => false
      t.datetime :created_on
      t.datetime :updated_on
  end
  fixtures :users

  create_table :groups do |t|
      t.string   :name, :null => false
      t.datetime :created_on
      t.datetime :updated_on
  end
  fixtures :groups


    create_table :user_groups do |t|
      t.integer :user_id, :null => false
      t.integer :group_id, :null => false
      t.integer :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
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
      t.datetime :created_on
      t.datetime :updated_on
    end

    create_table :product_categories do |t|
      t.string   :name, :null => false
      t.integer :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
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

    create_table :rooms do |t|
      t.integer  :building_id, :null => false
      t.integer  :room_type_id, :null => false
      t.string   :number
      t.string   :floor
      t.string   :name
      t.integer  :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
    end

    create_table :room_types do |t|
      t.string   :name, :null => false
      t.integer  :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
    end

    create_table :buildings do |t|
      t.string   :name, :null => false
      t.integer  :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
    end

    # SALVA
    create_table :people, :force => true do |t|
        t.integer  :user_id,            :null => false
        t.text     :firstname,          :null => false
        t.text     :lastname1,          :null => false
        t.text     :lastname2
        t.boolean  :gender,             :null => false
        t.integer  :moduser_id
        t.datetime :created_on
        t.datetime :updated_on
    end
    fixtures :people

    create_table :addresses, :force => true do |t|
        t.integer    :user_id,               :null => false
        t.text       :location,              :null => false
        t.text       :phone
        t.text       :fax
        t.text       :movil
        t.integer    :moduser_id
        t.datetime   :created_on
        t.datetime  :updated_on
    end
    fixtures :addresses
    
    create_table :adscriptions do |t|
        t.string   :name, :null => false
        t.integer  :moduser_id
        t.datetime :created_on
        t.datetime :updated_on
    end
    fixtures :adscriptions

    create_table :user_adscriptions do |t|
      t.integer  :user_id, :null => false
      t.integer  :adscription_id, :null => false
      t.integer  :moduser_id
      t.datetime :created_on
      t.datetime :updated_on
    end
    fixtures :user_adscriptions
    
end

  def self.down
     drop_table :users, :groups, :user_groups, :products, :product_types, :product_groups, :features, 
                :product_features, :orders, :providers, :buildings, :rooms, :room_types,
                :people, :addresses, :adscriptions, :user_adscriptions     # SALVA
  end
end




