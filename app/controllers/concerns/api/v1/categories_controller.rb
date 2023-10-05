class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request, :set_library
  before_action :set_category, only: [ :show, :update, :destroy]

  def index
    @categories = @library.categories
    render json: @categories, status: :ok
  end

  def create
    authorize_admin_librarian
    return if response_body.present? # Add this line to stop execution if response is already rendered
    @category = @library.categories.build(category_params)

    if @category.save
      render json: @category.library.categories, status: :created
    else 
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def show
    render json: @category, status: :ok
  end

  def update
    authorize_admin_librarian
    return if response_body.present? # Add this line to stop execution if response is already rendered
    if @category.update(category_params)
      render json: @category.library.categories, status: :ok
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    authorize_admin_librarian
    return if response_body.present? # Add this line to stop execution if response is already rendered
    if @category.destroy
      render json: { message: 'Category deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete category' }, status: :unprocessable_entity
    end
  end

  private

  def set_library
    @library = Library.find(params[:library_id])
  end

  def category_params
    params.permit(:name, :library_id, :id)
  end

  def set_category
    @category = @library.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound 
    render json: { errors: 'Category not found' }, status: :not_found
  end
end
