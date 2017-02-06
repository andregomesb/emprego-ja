class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  #include ActionController::MimeResponds
  #skip_before_action :verify_authenticity_token
  #include ActionController::Serialization



    before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end


end
