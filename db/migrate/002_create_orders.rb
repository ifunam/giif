class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :project_types do |t| # Link this table to administrative system (presupuesto, partidas, etc)
      t.text     :name, null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :projects do |t|
      t.text     :name, null => false
      t.string   :key # todo: Verify if :key is required and not null
      t.integer  :project_type_id, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :order_statuses do |t|
      t.text     :name, null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :orders do |t|
      t.integer  :user_id, :null => false
      t.integer  :user_incharge_id, :null => false
      t.date :date, :null => false
      t.integer  :administrative_key, :null => false
      t.string   :provider_id, :null => false
      t.integer  :order_status_id, :null => false, :default => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :order_products do |t|
      t.integer  :order_id, :null => false
      t.integer  :quantity, :null => false
      t.text     :description, :null => false
      t.text     :unit # todo: Verify if :unit  is required and not null
      t.float  :price_per_unit, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :file_types do |t|
      t.text     :name, null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :order_files do |t|
      t.integer  :order_id, :null => false
      t.binary    :file, :null => false
      t.string   :content_type, :null => false
      t.string   :filename, :null => false
      t.integer  :file_type_id, :null => false
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

    create_table :order_providers do |t|
      t.integer  :order_id, :null => false
      t.integer  :provider_id, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end

    create_table :order_logs do |t|
      t.integer  :order_id, :null => false
      t.integer  :user_id, :null => false
      t.integer  :user_incharge_id
      t.integer  :order_status_id, :null => false
      t.integer  :moduser_id
      t.datetime :created_on, :null => false
      t.datetime :updated_on, :null => false
    end
  end

  def self.down
    drop_table :orders
  end
end
