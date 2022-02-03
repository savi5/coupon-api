class AddForeignKeyToCustomerEntityCustomerAdditionalInfo < ActiveRecord::Migration
  def change
  	add_foreign_key :customer_additional_infos, :customer_entities, column: :customer_entity_id, on_delete: :cascade
  end

  def down
  	remove_foreign_key :customer_additional_infos, column: :customer_entity_id, if_exists: true
  end
end
