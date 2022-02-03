class SalesFlatCoupon < ActiveRecord::Base
	self.table_name = "sales_flat_coupons"
	belongs_to :customer_entity
end
