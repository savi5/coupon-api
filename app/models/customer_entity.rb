
class CustomerEntity < ActiveRecord::Base
	self.table_name = 'customer_entities'
	validates :name,:email,:mobile, presence: true

	has_one :customer_additional_info, dependent: :destroy
	has_many :sales_flat_coupons

    before_validation :capitalize, on: :create
    after_destroy :disable_coupons


	def self.create_user params
        begin
			user = {}
        	ActiveRecord::Base.transaction do
			user = CustomerEntity.create!(name: params[:name],
				email: params[:email],
				mobile: params[:mobile])
			user.create_customer_additional_info(birthday: params[:birthday],anniversary: params[:anniversary]) if params[:birthday].present? || params[:anniversary].present?
			end
			return user
	    rescue => e 
			puts e.message
        	return false
		end
	end

    def update_user params
		begin
		ActiveRecord::Base.transaction do
			user_params = {}
			user_params[:email] = params[:email] if params[:email].present?
			user_params[:mobile] = params[:mobile] if params[:mobile].present?
			user_params[:name] = params[:name] if params[:name].present?
			self.update(user_params)
			self.build_customer_additional_info unless self.customer_additional_info
			self.customer_additional_info.update_attributes(birthday: params[:birthday],anniversary: params[:anniversary]) if params[:birthday].present? || params[:anniversary].present?
		end
		return true
		rescue => e
			e.message
			return false
		end
    end

	def capitalize
		self.name = name.downcase.titleize if name.present?
	end


	def disable_coupons
		self.sales_flat_coupons.update_all(is_active: 0) if self.sales_flat_coupons
	end

    def get_customer_details
		customer = {}
		customer[:name] = self.name
		customer[:email] = self.email
		customer[:mobile] = self.mobile
		customer_additional_info = self.customer_additional_info
		if(customer_additional_info.present?)
			customer[:birthday] = customer_additional_info["birthday"]
			customer[:anniversary] = customer_additional_info["anniversary"]
		end
		customer
    end


end
