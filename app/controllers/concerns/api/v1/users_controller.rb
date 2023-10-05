class Api::V1::UsersController < ApplicationController
  # include AdminAuthorization
  
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    authorize_admin
    return if response_body.present? # Add this line to stop execution if response is already rendered
    @users = User.all
    render json: @users , status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user , status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user , status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}

  def update
    authorize_admin
    return if response_body.present? # Add this line to stop execution if response is already rendered
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  # DELETE /users/{username}
  def destroy
    authorize_admin
    return if response_body.present? # Add this line to stop execution if response is already rendered
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :username, :email, :password, :password_confirmation, :mobile_no, :role
    )
  end
end

