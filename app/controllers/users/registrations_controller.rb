class Users::RegistrationsController < Devise::RegistrationsController
    
    before_action :select_plan, only: :new #Only when creating a new plan.
    
# Extending default devise gem create action so users signing up with pro account(plan id 2)
# save with special stripe subscription function.
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
    
    private #Private means only using this function inside the cntroller file
        def select_plan # If params are changed redirect user.
            unless (params[:plan] == '1' || params[:plan] == '2')
                flash[:notice] = "Please select a membership plan to sign up."
                redirect_to root_url
            end
        end
end