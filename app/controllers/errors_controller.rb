class ErrorsController < ApplicationController

  def not_found
    respond_to do |format|
    	format.all { render status: 404 }
    end  
    rescue ActionController::UnknownFormat
    render status: 404
  end

end