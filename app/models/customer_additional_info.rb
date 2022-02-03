class CustomerAdditionalInfo < ActiveRecord::Base
	self.table_name = "customer_additional_infos"
	belongs_to :customer_entity

	
end
