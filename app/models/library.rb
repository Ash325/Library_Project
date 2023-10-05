class Library < ApplicationRecord
  belongs_to :user

  has_many :categories

  validates :name, :email, :contact_no, :user_id, presence: true, uniqueness: true
  validates :description, presence: true
  # :rating, 
end
