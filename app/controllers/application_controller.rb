class ApplicationController < ActionController::API
	include JsonWebToken

	before_action :authenticate_request

	private
	def authenticate_request
		begin
			header = request.headers["Authorization"]
			header = header.split(" ").last if header
			decoded = jwt_decode(header)
			@current_user = User.find(decoded[:user_id])
		rescue
			render json: {error: "User not authorized Token"}
		end
	end
end
