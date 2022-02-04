module API::V1
    class Customer < Grape::API
          require './lib/api/validation'
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
            requires :name,type: String,allow_blank: false,alpha: true,min_length: 2,desc: 'Name of the user'
            requires :email, type: String,allow_blank: false,email: true,desc: 'Email of the user'
            requires :mobile, type: String,desc: 'Mobile no of the user', mobile: true
            optional :birthday, type: Date,desc: 'Birth date of the user'
            optional :anniversary, type: Date, desc: 'Spouse birthday for the user'
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

        desc 'Update user'
        params do
            requires :user_id,as: :customer_entity_id,type: Integer, allow_blank: false,desc: 'User id'
            optional :name,type: String,allow_blank: false,alpha: true,min_length: 2,desc: 'Name of the user'
            optional :email, type: String,allow_blank: false,email: true,desc: 'Email of the user'
            optional :mobile, type: String,desc: 'Mobile no of the user', mobile: true
            optional :birthday, type: Date,desc: 'Birth date of the user'
            optional :anniversary, type: Date, desc: 'Spouse birthday for the user'
        end
        put '/:user_id' do
            user = CustomerEntity.find_by_id(params[:customer_entity_id])
            status = {}
            if(user.blank?)
                status(404)
                status = { code: false, message: 'User not found' }
            else
            result = user.update_user(params)
            status = {}
                if result.blank?
                    status(404)
                    status = { code: false, message: 'Something went wrong' }
                else
                    status(200)
                    status = { code: true , message:'User updated successfully',user: result}
                end
            end
            status

        end

        desc 'Delete user'
        params do
            requires :user_id,as: :customer_entity_id,type: Integer, allow_blank: false,desc: 'User id'
        end
        delete '/:user_id' do
            user = CustomerEntity.find_by_id(params[:customer_entity_id])
            status = {}
            if(user.blank?)
                status(404)
                status = { code: false, message: 'User not found' }
            else
            result = user.destroy
            status = {}
                if result.blank?
                    status(404)
                    status = { code: false, message: 'Something went wrong' }
                else
                    status(200)
                    status = { code: true , message:'User deleted successfully',user: result}
                end
            end
            status

        end
       

        end
    end
end