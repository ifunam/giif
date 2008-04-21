class Schema   < ActiveRecord::Migration
  def self.up
    create_table :people, :force => true do |t|
      t.references :user, :null => false
      t.string     :firstname, :lastname1, :null => false
      t.string     :lastname2
      t.boolean    :gender,             :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end
  
    create_table :addresses, :force => true do |t|
      t.references :user, :null => false
      t.text    :location,              :null => false
      t.string  :phone, :fax, :movil
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end
  
    create_table :user_adscriptions do |t|
      t.references  :user, :adscription, :null => false
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :adscriptions do |t|
      t.string      :name, :null => false
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end
    
    create_table :users  do |t|
      t.string  :login, :email, :null => false
      t.text    :password, :salt, :null => false
      t.boolean :status, :null => false
      t.references  :user_incharge, :class_name => 'User', :foreign_key => "user_incharge_id"
      t.timestamps
    end
      
    create_table :groups do |t|
      t.string   :name, :null => false
      t.timestamps
    end

    create_table :user_groups do |t|
      t.references :user, :group, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :products do |t|
      t.references  :product_type, :null => false
      t.string   :model, :vendor, :null => false
      t.string   :inventory_number, :serial_number, :description, :ip_adress, :mac_adress, :speed
      t.boolean  :is_wired
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :product_types do |t|
      t.string      :name, :null => false
      t.references  :product_category, :null => false
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :product_categories do |t|
      t.string   :name, :null => false
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :features do |t|
      t.string   :name, :null => false
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :products_features do |t|
      t.references :product, :feature, :null => false
      t.text       :description, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :rooms do |t|
      t.references  :building, :room_type, :null => false
      t.string      :number, :floor, :name
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :room_types do |t|
      t.string    :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :buildings do |t|
      t.string      :name, :null => false
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    fixtures :users  
    add_index :users, [:id], :name => "users_id_idx"
    add_index :users, [:login], :name => "users_login_idx"
    add_index :users, [:email], :name => "users_email_key", :unique => true
    
    fixtures :groups
    add_index :groups, [:name], :name => "groups_name_idx"
  end

  def self.down
    drop_table :users, :groups, :user_groups, :products, :product_types, :product_groups, :features,
    :product_features, :orders, :providers, :buildings, :rooms, :room_types,
    :people, :addresses, :adscriptions, :user_adscriptions     # SALVA
  end
end




