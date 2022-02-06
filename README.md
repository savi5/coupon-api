# coupon-api
Coupon generator system.

* Ruby version -> 2.3.0

* System dependencies
    Rails 4.2.6

* Configuration

    $ bundle install

* Database creation

    $ rake db:create

* Database initialization

    $ rake db:migrate
    $ rake db:seed

* How to run the test suite

    $ rspec

* Services (job queues, cache servers, search engines, etc.)

      OccasionCouponWorker (Sidekiq worker to generate coupons for users having occasion in current date).
      
         $ rails s
         $ bundle exec sidekiq
         $ redis-server
         $ rails c
               -> OccasionCouponWorker.new.perform("birthday")


* Deployment instructions

        To execute APIs
           $ rails s

* APIs 
     
   USER APIs : 

        CREATE USER : POST localhost:3000/api/v1/customer/?email=testUserC@gmail.com&mobile=9988775511&name=Sristi&anniversary=2021-02-11&birthday=1992-02-06

         RESPONSE : 
              {
            "code": true,
            "message": "User Created successfully",
            "data": {
                "name": "Sristi",
                "email": "testUserC@gmail.com",
                "mobile": "9988775511",
                "birthday": "1992-02-06",
                "anniversary": "2021-02-11"
            }
        }

        GET ALL USERS : GET localhost:3000/api/v1/customer

        UPDATE USER : PUT localhost:3000/api/v1/customer/15?anniversary=2021-11-30

         RESPONSE :  
         {
              "code": true,
              "message": "User updated successfully",
              "data": {
                  "name": "Sristi",
                  "email": "testUserC@gmail.com",
                  "mobile": "9988775511",
                  "birthday": null,
                  "anniversary": "2021-11-30"
              }
          }

         DELETE USER  : DELETE localhost:3000/api/v1/customer/13

         RESPONSE :
         {
        "code": true,
        "message": "User deleted successfully"
         }



    COUPON APIs

      CREATE COUPON FOR USER  : localhost:3000/api/v1/coupon/user/15?occasion=others
      RESPONSE :
      {
          "code": true,
          "message": "Coupon Created successfully",
          "data": {
              "customer_entity_id": 15,
              "coupon": "FRE151644185433",
              "coupon_type": 3,
              "is_active": true,
              "is_used": false,
              "expiry": "2022-03-09"
          }
      }
    
      UPDATE COUPON : localhost:3000/api/v1/coupon/10/?expiry=2022-04-12
      RESPONSE : 
      {
          "code": true,
          "message": " updated successfully",
          "data": {
              "customer_entity_id": 14,
              "coupon": "BDAY141644170185",
              "coupon_type": 1,
              "is_active": true,
              "is_used": false,
              "expiry": "2022-04-12"
          }
      }
      
      DELETE COUPON : localhost:3000/api/v1/coupon/13
      RESPONSE :
      {
          "code": true,
          "message": "Coupon deleted successfully"
      }
      
      GET COUPON COUNT : localhost:3000/api/v1/coupon/count //Used redis to store count, value will be updated after creation/deletion of coupon
      RESPONSE :
      "10"

      FETCH ALL COUPONS : localhost:3000/api/v1/coupon/
       RESPONSE : 
                 {
            "code": true,
            "message": "Fetched successfully",
            "data": [
                {
                    "id": 2,
                    "customer_entity_id": 4,
                    "coupon": "BDAY41643996250",
                    "coupon_type": 1,
                    "is_active": true,
                    "is_used": false,
                    "expiry": "2022-03-06",
                    "created_at": "2022-02-04T17:37:33.000Z",
                    "updated_at": "2022-02-04T17:37:33.000Z"
                },
                {
                    "id": 3,
                    "customer_entity_id": 5,
                    "coupon": "BDAY41643996261",
                    "coupon_type": 1,
                    "is_active": true,
                    "is_used": false,
                    "expiry": "2022-03-06",
                    "created_at": "2022-02-04T17:37:42.000Z",
                    "updated_at": "2022-02-04T17:37:42.000Z"
                },
                {
                    "id": 14,
                    "customer_entity_id": 6,
                    "coupon": "FRE61644185392",
                    "coupon_type": 3,
                    "is_active": true,
                    "is_used": false,
                    "expiry": "2022-03-09",
                    "created_at": "2022-02-06T22:09:52.000Z",
                    "updated_at": "2022-02-06T22:09:52.000Z"
                },
                {
                    "id": 15,
                    "customer_entity_id": 15,
                    "coupon": "FRE151644185433",
                    "coupon_type": 3,
                    "is_active": true,
                    "is_used": false,
                    "expiry": "2022-03-09",
                    "created_at": "2022-02-06T22:10:33.000Z",
                    "updated_at": "2022-02-06T22:10:33.000Z"
                }
            ]
        }
         
      

    
