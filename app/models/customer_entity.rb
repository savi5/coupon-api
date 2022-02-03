class CustomerEntity < ActiveRecord::Base
	self.table_name = 'customer_entities'
	validates :name,:email,:mobile, presence: true

	has_one :customer_additional_info
	has_many :sales_flat_coupons

    before_validation :capitalize, on: :create


	def self.create_user params
        begin
        	ActiveRecord::Base.transaction do
			user = CustomerEntity.create!(name: params[:name],
				email: params[:email],
				mobile: params[:mobile])
			user.create_customer_additional_info(birthday: params[:birthday],anniversary: params[:anniversary]) if params[:birthday].present? || params[:anniversary].present?
			end
			return true
	    rescue => e 
			puts e.message
        	return false
		end
	end


	def capitalize
		self.name = name.downcase.titleize if name.present?
	end




end
