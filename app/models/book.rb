class Book < ApplicationRecord
  # after_save :update_category_no_of_book
  after_create :update_category_no_of_book
  after_destroy :update_category_no_of_book
  

  belongs_to :category
  belongs_to :library
  
  # has_one_attached :book_img
  # has_one_attached :author_img

  

  validates :author, :language , :publication_date, presence: true
  validates :name, presence: true, uniqueness: { scope: :library_id }


  

  private

  def update_category_no_of_book
    category.update(no_of_book: category.books.count) 
  end


end
