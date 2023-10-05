class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from JWT::DecodeError, with: :jwt_decode_error

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
      role = @current_user.role
      time=Time.at(@decoded[:exp])

      puts "Time expiry: #{time}"
      puts "Time now: #{Time.now}"
      
    if @decoded[:exp].present? && Time.now > time
      render json: { error: 'Token expired' }, status: :unauthorized
      return
    end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def authorize_admin
    unless @current_user.role == 'admin'
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end

  def authorize_admin_librarian
    library = Library.find(params[:library_id])
    unless (@current_user.role == "admin") || (@current_user.role == "librarian" && @current_user.id == library.user_id)
      render json: { errors: 'Unauthorized' }, status: :unauthorized
      return
    end
  end

  private

  def record_not_found
    render json: { errors: 'Record not found' }, status: :not_found
  end

  def jwt_decode_error
    render json: { errors: 'Invalid token' }, status: :unauthorized
  end
end
