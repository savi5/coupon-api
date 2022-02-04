require 'rails_helper'


describe 'Testcases for customer APIs' ,type: :request do
  

  context 'POST /api/v1/customer/' do
    it 'Returns created customer' do
      statuses = {
            email: 'test123@gmail.com',mobile:'9883241321', name:'testuser'
          }
      post '/api/v1/customer',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 201
      expect(result["code"]).to eq true
    end
  end

  context 'GET /api/v1/customer/' do
    it 'Returns customer details' do
      get '/api/v1/customer/'
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result["code"]).to eq true
    end
  end
  

  context 'POST /api/v1/customer/' do
    it 'Returns unique constraint error on email column' do
      statuses = {
            email: 'test123@gmail.comq',mobile:'9043231234', name:'sasda'
          }
      post '/api/v1/customer',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 500
      expect(result["code"]).to eq false
    end
  end

  context 'POST /api/v1/customer/' do
    it 'Returns required email validation error' do
      statuses = {
          mobile:'9043231234', name:'sasda'
          }
      post '/api/v1/customer',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 400
      expect(result["error"]).to eq "email is missing, email is empty, email format is incorrect "
    end
  end


  context 'PUT /api/v1/customer/1' do
    it 'Returns updated record status' do
      statuses = {
          mobile:'9043231234', name:'testUserB'
          }
      put '/api/v1/customer/1',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result["data"]["name"]).to eq 'testUserB'
    end
  end

  context 'PUT /api/v1/customer/1' do
    it 'Updating birthday in customer_additional_info table' do
      statuses = {
          birthday: '1997-01-31'
          }
      put '/api/v1/customer/1',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result["data"]["birthday"]).to eq "1997-01-31"
    end
  end

  context 'PUT /api/v1/customer/1000' do
    it 'Updating non existing user record status' do
      statuses = {
          mobile:'9043231234', name:'testUserB'
          }
      put '/api/v1/customer/1000',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 404
      expect(result["message"]).to eq "User not found"
    end
  end

  context 'PUT /api/v1/customer/1' do
    it 'Updating invalid date' do
      statuses = {
           birthday: '77891'
          }
      put '/api/v1/customer/1',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 400
      expect(result["error"]).to eq "birthday is invalid"
    end
  end


  context 'DELETE /api/v1/customer/77' do
    it 'Returns deleted record status' do
      delete '/api/v1/customer/77'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result["code"]).to eq true
    end
  end

  context 'DELETE /api/v1/customer/1' do
    it 'Cascade delete check on customer_additional_info' do
      statuses = {
          birthday: '1997-01-31'
          }
      put '/api/v1/customer/1',statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      customer_additional_info = CustomerAdditionalInfo.find_by_customer_entity_id(1)
      expect(customer_additional_info.present?).to eq true
      delete '/api/v1/customer/1'
      puts response.body
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result["code"]).to eq true
      customer_additional_info = CustomerAdditionalInfo.find_by_customer_entity_id(1)
      expect(customer_additional_info.present?).to eq false
    end
  end

end