class Api::V1::LibrariesController < ApplicationController
    before_action :authorize_request
    before_action :set_library, only: [:show, :update, :destroy]
  
    def index
      @libraries = Library.all
      render json: @libraries, status: :ok
    end
  
    def create
      authorize_admin
      return if response_body.present? # Add this line to stop execution if response is already rendered
      @library = Library.new(library_params)
  
      if @library.save
        render json: @library, status: :created
      else
        render json: { errors: @library.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      render json: @library, status: :ok
    end
  
    def update
      authorize_admin
      return if response_body.present? # Add this line to stop execution if response is already rendered
      if @library.update(library_params)
        render json: @library, status: :ok
      else
        render json: { errors: @library.errors.full_messages }, status: :unprocessable_entity
      end
    end
        

 
    def destroy
      authorize_admin
      return if response_body.present? # Add this line to stop execution if response is already rendered
      if @library.destroy
        render json: { message: 'Library deleted successfully' }, status: :ok
      else
        render json: { error: 'Failed to delete library' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def library_params
        params.permit(:name, :email, :contact_no, :description, :user_id, :rating)
    end
  
    def set_library
      @library = Library.find(params[:id])
  
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Library not found' }, status: :not_found
    end
  end