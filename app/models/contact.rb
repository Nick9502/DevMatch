class Contact < ActiveRecord::Base
    # Contact Form Validation. If not present. Wont save to DB
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true
end