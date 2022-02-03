class AddEmailUniquenessIndexToCustomerEntity < ActiveRecord::Migration
  def change
  	add_index :customer_entities, :email , unique: true
  end
end
