class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, :mobile_no, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 8 },
              format: { with: /\A(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]+\z/, message: "must include at least one number and one special character" },
          if: -> { new_record? || !password.nil? }

    validates :mobile_no, presence: true, uniqueness: true, length: { is: 10}, if: -> { new_record? || !password.nil? }

end
