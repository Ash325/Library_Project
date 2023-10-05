class Category < ApplicationRecord
  belongs_to :library, foreign_key: :library_id

  # has_one_attached :cat_img

  has_many :books

  validates :name, presence: true, uniqueness: { scope: :library_id }

  # validates :cat_img, presence: true

  after_initialize :set_initial_no_of_book

  
  private
  
  def set_initial_no_of_book
    self.no_of_book ||= 0
  end
  

end
