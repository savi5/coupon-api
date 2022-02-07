require 'rails_helper'


describe 'Testcases for coupon APIs' ,type: :request do
  

  context 'POST /api/v1/coupon/user/:user_id' do
    it 'Returns created coupon for user' do
      statuses = {
            occasion: "birthday"
          }
      post '/api/v1/coupon/user/78',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 201
      expect(result["code"]).to eq true
    end
  end

  context 'GET /api/v1/coupon/' do
    it 'Fetch all coupons' do
      get '/api/v1/coupon/'
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result["code"]).to eq true
    end
  end


  context 'GET /api/v1/coupon/count' do
     it 'Get coupons count' do
      count = $redis.get("total_coupon_count") || SalesFlatCoupon.count
      get '/api/v1/coupon/count'
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      puts result
      expect(result["count"]).to eq count.to_s
    end
  end


end