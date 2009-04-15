class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :order_statuses do |t|
      t.string     :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :controllers do |t|
      t.string :name, :null => false
      t.timestamps
    end

    create_table :permissions do |t|
      t.references :order_status, :controller, :null => false
      t.text :action, :null => false
      t.text :method, :default => "get"
      t.boolean :is_remote, :null => false, :default => false
      t.timestamps
    end    

    create_table :orders do |t|
      t.references :user, :null => false
      t.references :order_status, :null => false, :default => 1
      t.references :user_incharge, :class_name => 'User', :foreign_key => "user_incharge_id"
      t.date       :date, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :project_types do |t| # NOTE: Link this table to administrative system (presupuesto, partidas, etc)
      t.string      :name, :null => false
      t.references  :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :projects do |t|
      t.references :order, :project_type, :null => false
      t.text       :name, :null => false
      t.string     :key # TODO: Verify if :key is required and not null
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :order_products do |t|
      t.references :order, :product_category, :unit_type,:null => false
      t.integer    :quantity, :null => false
      t.text       :description, :null => false
      t.text       :unit # TODO: Verify if :unit  is required and not null
      t.float      :price_per_unit
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :unit_types do |t|
      t.string     :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps      
    end

    create_table :file_types do |t|
      t.string     :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :order_files do |t|
      t.references :order, :file_type, :null => false
      t.binary     :file, :null => false
      t.string     :content_type, :filename, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :providers do |t|
      t.string     :name, :null => false
      t.string     :email
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :order_providers do |t|
      t.references :order, :provider, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :order_logs do |t|
      t.references :order, :user, :order_status, :null => false
      t.references :user_incharge, :class_name => 'User', :foreign_key => "user_incharge_id"
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :currencies do|t|
      t.string     :name, :null => false
      t.text       :url, :conversion_title
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :currency_orders do |t|
      t.references :order, :currency, :null => false
      t.float :value, :null => false
      t.timestamps
    end

    create_table :direct_adjudication_types do |t|
      t.string     :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :acquisitions do |t|
      t.references :order, :user, :direct_adjudication_type, :null => false
      t.boolean    :is_subcomittee_invitation, :null => false # TODO: verify if :is_subcomittee is  boolean or catalog
      t.boolean    :is_subcomittee_bid, :null =>false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

    create_table :budgets do |t|
      t.references :order, :user, :null => false
      t.integer   :previous_number, :null => false
      t.string     :code, :external_account, :null => false
      t.text       :observations
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      t.timestamps
    end

  end

  def self.down
    drop_table :project_types, :projects, :order_statuses, :controllers, :permissions, :orders, :order_products,
    :file_types, :order_files, :providers, :order_providers, :order_logs, :currencies,
    :currency_orders, :direct_adjudication_types, :acquisitions, :files_uploaded, :budgets, :unit_types
  end
end
