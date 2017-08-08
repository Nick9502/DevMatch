class Users::RegistrationsController < Devise::RegistrationsController
#Extending create action to allow us to check plan and save with subscription if plan_id=2
    def create 
        super do |resource| #Super allows us to inherit create action and extend it.
            if params[:plan] #Checks for parameter called plan in url(Basic or pro form)
                resource.plan_id = params[:plan] #Set user plan id to param.
                if resource.plan_id == 2
                   resource.save_with_subscription
                else
                    resource.save
                end
                
            end
        end
    end
end