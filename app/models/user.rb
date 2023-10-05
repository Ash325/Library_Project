class User < ApplicationRecord

    enum role: { admin: 0, librarian: 1, general: 2 }   
    after_initialize :set_default_role, if: :new_record?
    
    has_one :libraries

    has_secure_password

    validates :email, :username, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
              length: { minimum: 8 },
              format: { with: /\A(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]+\z/, message: "must include at least one number and one special character" },
          if: -> { new_record? || !password.nil? }

    validates :mobile_no, presence: true, uniqueness: true, length: { is: 10}, if: -> { new_record? || !password.nil? }

    private

    def set_default_role
        self.role ||= :general
    end

end
