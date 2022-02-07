# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CustomerEntity.create(name:"testUserAA",email:"testAA@gmail.com",mobile:"9043231234")
CustomerEntity.create(name:"testUserBB",email:"testBB@gmail.com",mobile:"9043231222")

CustomerAdditionalInfo.create(birthday: '1992-02-06',anniversary: '2021-02-11', customer_entity_id: 1)

SalesFlatCoupon.create(customer_entity_id: 1,coupon: "BDAY141643996309",coupon_type: 1,is_active: 1,is_used: 0, expiry: "2022-03-06")