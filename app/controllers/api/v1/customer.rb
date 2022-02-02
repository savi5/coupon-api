module API::V1
    class Customer < Grape::API
        resource :customer do 

            desc 'Get users'
            get '/' do
                result = CustomerEntity.all
                 status = {}
                if result.blank?
                    status(404)
                    status = { code: false, message: 'Something went wrong' }
                else
                    status(200)
                    status = { code: true , message:'Fetched successfully',users: result}
                end
            status
                 
            end

        desc 'Create user'
        params do
        requires :name,type: String,desc: 'Name of the user', allow_blank: false, regexp: /w+/
        requires :email, type: String,desc: 'Email of the user',allow_blank: false, regexp: /.+@.+/
        requires :mobile, type: Numeric,desc: 'Mobile no of the user'
        end
        post '/' do
            result = CustomerEntity.create_user(params)
            status = {}
                if result.blank?
                    status(404)
                    status = { code: false, message: 'Something went wrong' }
                else
                    status(200)
                    status = { code: true , message:'User Created successfully',user: result}
                end
            status

        end
        end
    end
end