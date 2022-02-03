class CreateCustomerAdditionalInfo < ActiveRecord::Migration
  def change
    create_table :customer_additional_infos do |t|
    	t.references :customer_entities
    	t.date :birthday
    	t.date :anniversary
    	t.timestamps null: false
    end
  end

  def down
     drop_table :customer_additional_infos
  end
end
