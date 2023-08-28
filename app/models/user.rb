class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true
    validates :password, confirmation: true
    validates :password_confirmation, presence: true, allow_nil: true
   


end
