# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def not_found
    render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end
end
