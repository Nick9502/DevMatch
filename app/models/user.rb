class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  
  attr_accessor :stripe_card_token #To take form data and use it you whitelist it.
  def save_with_subscription
    if valid? #Check user validations. password, password confirm, email, etc.
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id #Save csutomer token to User.
      save! #Runs save on spot and inserts to database.(Rails)
    end
  end
end
