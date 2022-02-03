class CreateSalesFlatCoupon < ActiveRecord::Migration
  def change
    create_table :sales_flat_coupons do |t|
    	t.references :customer_entities
    	t.string :coupon 
    	t.integer :coupon_type
    	t.boolean :is_active
    	t.boolean :is_used
    	t.date :expiry
    	t.timestamps null: false
    end
  end

  def down
  	  drop_table :sales_flat_coupons
  end
end
