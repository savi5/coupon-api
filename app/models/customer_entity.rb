class CustomerEntity < ActiveRecord::Base
	self.table_name = 'customer_entities'
	validates :name,:email,:mobile, presence: true



	def self.create_user params
        
		user = CustomerEntity.create(name: params[:name],
			email: params[:email],
			mobile: params[:modile])
		user

	end
end
