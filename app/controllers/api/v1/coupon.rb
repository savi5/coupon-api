module API::V1
    class Coupon < Grape::API
          require './lib/api/validation'
            resource :coupon do 

                desc 'Get coupons'
                get '/' do
                    result = SalesFlatCoupon.all
                     status = {}
                    if result.blank?
                        status(500)
                        status = { code: false, message: 'Something went wrong' }
                    else
                        status(200)
                        status = { code: true , message:'Fetched successfully',data: result}
                    end
                status
                     
                end

            desc 'Create coupon for user'
            params do
                requires :user_id,as: :customer_entity_id,type: Integer, allow_blank: false,desc: 'User id'
                requires :occasion, type: String, values:   ['birthday','anniversary','others' ]
            end
            post '/user/:user_id' do
                user = CustomerEntity.find_by_id(params[:customer_entity_id])
                status = {}
                if(user.blank?)
                    status(404)
                    status = { code: false, message: 'User not found' }
                else
                    result = SalesFlatCoupon.create_coupon(params)
                    status = {}
                        if result.blank?
                            status(500)
                            status = { code: false, message: 'Something went wrong' }
                        else
                            status(201)
                            status = { code: true , message:'Coupon Created successfully',data: result.get_coupon_details}
                        end
                end
                status

            end

            desc 'Update coupon'
            params do
                requires :coupon_id,as: :id,type: Integer, allow_blank: false,desc: 'Coupon id'
                optional :user_id,as: :customer_entity_id,type: Integer, allow_blank: false,desc: 'User id'
                optional :expiry, type: Date, allow_blank: false,desc: 'expiry date'
                optional :is_active,type: Boolean,desc: 'is coupon active'
                optional :is_used,type: Boolean,desc: 'is coupon used'
            end
            put '/:coupon_id' do
                coupon = SalesFlatCoupon.find_by_id(params[:id])
                status = {}
                if(coupon.blank?)
                    status(404)
                    status = { code: false, message: 'Coupon not found' }
                else
                result = coupon.update_coupon(params)
                status = {}
                    if result.blank?
                        status(500)
                        status = { code: false, message: 'Something went wrong' }
                    else
                        status(200)
                        status = { code: true , message:' updated successfully',data: coupon.get_coupon_details}
                    end
                end
                status

            end

            desc 'Delete coupon'
            params do
                requires :coupon_id,as: :id,type: Integer, allow_blank: false,desc: 'Coupon id'
            end
            delete '/:coupon_id' do
                coupon = SalesFlatCoupon.find_by_id(params[:id])
                status = {}
                if(coupon.blank?)
                    status(404)
                    status = { code: false, message: 'Coupon not found' }
                else
                result = coupon.destroy
                status = {}
                    if result.blank?
                        status(500)
                        status = { code: false, message: 'Something went wrong' }
                    else
                        status(200)
                        status = { code: true , message:'Coupon deleted successfully'}
                    end
                end
                status

            end
           

           desc 'Count of coupons'
           get '/count' do
                coupon_count = SalesFlatCoupon.get_coupon_count
                coupon_count
           end

        end
    end
end