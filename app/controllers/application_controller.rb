# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, if: proc { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }

  before_action :authenticate_user!

  respond_to :html, :json
end
