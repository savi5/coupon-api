class SalesFlatCoupon < ActiveRecord::Base
	self.table_name = "sales_flat_coupons"
	belongs_to :customer_entity
	COUPON_TYPE = {"birthday"=>1, "anniversary"=>2, "others"=>3}
	COUPON_CODE = {"birthday"=> "BDAY", "anniversary"=> "ANV", "others"=> "FRE"}

	validate :is_exist?,on: :create

	after_create -> {update_coupon_count(1)}
	after_destroy -> {update_coupon_count(-1)}


	def self.create_coupon params
		begin
			coupon_id = generate_coupon(params)
			coupon = SalesFlatCoupon.create!(customer_entity_id:params[:customer_entity_id],coupon: coupon_id,coupon_type: COUPON_TYPE[params[:occasion]],
				is_active: 1,is_used: 0, expiry: Time.now + 30.days)
			return coupon
	    rescue => e
			puts e.message
			return false
		end
	end

    def update_coupon params
		begin
		  coupon = self.update(params)
		coupon
		rescue => e
			puts e.message
			return false
		end
    end

	def self.generate_coupon params
		return COUPON_CODE[params[:occasion]]+params[:customer_entity_id].to_s+Time.now.to_i.to_s
	end


	def is_exist?
		coupon_exist = SalesFlatCoupon.where(coupon_type: self.coupon_type,customer_entity_id: self.customer_entity_id).first.blank?
		errors.add(:coupon, "already exist" ) unless coupon_exist
	end

	def self.get_coupon_count
		coupon_count = $redis.get("total_coupon_count")
         if(coupon_count.blank?)
            coupon_count = SalesFlatCoupon.count
            $redis.set("total_coupon_count",coupon_count,ex: 24.hours)
         end
        coupon_count
	end

	def update_coupon_count(append)
			coupon_count = SalesFlatCoupon.get_coupon_count.to_i + append
			$redis.set("total_coupon_count",coupon_count,keepttl: true)
	end

	def get_coupon_details
		coupon_details = {}
		coupon_details[:customer_entity_id] = self.customer_entity_id
		coupon_details[:coupon] = self.coupon
		coupon_details[:coupon_type] = self.coupon_type
		coupon_details[:is_active] = self.is_active
		coupon_details[:is_used] = self.is_used
		coupon_details[:expiry] = self.expiry
		coupon_details
	end
end
