class DiscountsController < ApplicationController
	
	def destroy
		@discount = Discount.find params[:id]
    if params[:admin] && @discount.present?
      @discount.destroy
      params[:tabtag].present? ? tabtag = params[:tabtag] : tabtag = "discounts"
      flash.now[:success] = "Discount lead information has been deleted"
      redirect_to "/catalog/admin/leads#"+"#{tabtag}"
    else

    end
	end

  def general_discounts_download
    @user = spree_current_user
    if @user.admin?
      @discounts = Discount.includes(:location).where(wedding: false)
      respond_to do |format|
        format.csv { send_data @discounts.to_general_csv }
      end
    else
      return
    end
  end

  def wedding_discounts_download
    @user = spree_current_user
    if @user.admin?
      @wedding_discounts = Discount.includes(:location).where(wedding: true)
      respond_to do |format|
        format.csv { send_data @wedding_discounts.to_wedding_csv }
      end
    else
      return
    end
  end  

end

