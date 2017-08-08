class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  
  attr_accessor :stripe_card_token #To take form data and use it you whitelist it.
  # If pro user passes validation(email, password, etc.)
  # call Stripe and tell Stripe to set user subscription
  # upon charging the customer's card.
  # Stripe responds back twith customer data.
  # Store customer.id as customer token and save user.
  def save_with_subscription
    if valid? 
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id #Save customer token to User.
      save! #Runs save on spot and inserts to database.(Rails)
    end
  end
end
