class CreateCustomerAdditionalInfo < ActiveRecord::Migration
  def change
    create_table :customer_additional_infos do |t|
    	t.belongs_to :customer_entity
    	t.date :birthday
    	t.date :anniversary
    	t.timestamps null: false
    end
  end

  def down
     drop_table :customer_additional_infos
  end
end
