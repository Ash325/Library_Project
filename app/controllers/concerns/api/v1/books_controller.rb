class Api::V1::BooksController < ApplicationController
    before_action :authorize_request, :set_library, :set_category
    before_action :set_book, only: [:edit, :show, :update, :destroy]
  
    def index
      @books = @category.books
      render json: @books, status: :ok

    end

  
    def create
      authorize_admin_librarian
      return if response_body.present? # Add this line to stop execution if response is already rendered
      @book = @category.books.build(book_params)
  
      if @book.save
        render json: @book, status: :created
      else
        render json: { errors: @book.errors.full_messages },
                status: :unprocessable_entity
      end
    end
  
  
    def show
        render json: @book, status: :ok
    end
  
  
    def update
      authorize_admin_librarian
      return if response_body.present? # Add this line to stop execution if response is already rendered
      if @book.update(book_params)
        render json: @book, status: :ok
      else
        render json: { errors: @book.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize_admin_librarian
      return if response_body.present? # Add this line to stop execution if response is already rendered
        if @book.destroy
          render json: { message: 'Book deleted successfully' }, status: :ok
        else
          render json: { error: 'Failed to delete book' }, status: :unprocessable_entity
        end
    end
  
    private
  
    def set_library
      @library = Library.find(params[:library_id])
    end
  
    def set_category
      @category = @library.categories.find(params[:category_id])
    end
  
    def book_params
      params.permit(:name, :author, :language, :publication_date, :category_id)
    end
  
    def set_book
      @book = @category.books.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: { errors: error.message }, status: :not_found
    end
end