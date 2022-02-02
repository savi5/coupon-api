class CreateCustomerEntity < ActiveRecord::Migration
  def change
    create_table :customer_entities do |t|
      t.string :name
      t.string :email
      t.string :mobile, limit: 20
      t.timestamps null: false
    end
    add_index :customer_entities, :email
  end

  def down
     remove_index :customer_entities,:email
     drop_table :customer_entities
  end
end
