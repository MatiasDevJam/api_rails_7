class User < ApplicationRecord

    has_many :products, dependent: :destroy
    has_many :orders, dependent: :destroy


    # bcrypt
    has_secure_password

    # validates user
    validates :email, uniqueness: true
    validates_format_of :email, with: /@/
    validates :password_digest, presence: true
end
