class OccasionCouponWorker
  include Sidekiq::Worker


  def perform(occasion)
    customers = fetch_customer_details(occasion)
    params = {}
    params[:occasion] = occasion
   	customers.each do |customer|
   		params[:customer_entity_id] = customer.customer_entity_id
   		SalesFlatCoupon.create_coupon(params)
   	end
  end

  def fetch_customer_details(occasion)
  	day = Time.now.day
    month = Time.now.month
    customer_data = CustomerAdditionalInfo.where("MONTH(#{occasion}) = ? AND DAY(#{occasion}) = ?",month,day)
    customer_data
  end

end
