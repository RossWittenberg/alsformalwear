module Spree
  class HomeController < Spree::StoreController
    respond_to :html

	  include DeviseHelper

    def index
    	redirect_to "/catalog/products"
    end
  end
end