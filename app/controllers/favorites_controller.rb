class FavoritesController < Spree::StoreController
  include Spree
  include DeviseHelper

  def user_favorites
    @user = spree_current_user
    if @user 
      @favorites = @user.favorites.select('distinct on (variant_id) *')
      render json: {favorites: @favorites}.to_json
    else
      render json: { favorites: "" }
    end
  end

  def create
    @user = spree_current_user
  	if params[:variantId]
  		@favorite = Favorite.new({ variant_id: params[:variantId], user_id: @user.id })
      if @favorite.save
  			render json: { success_message: "item has been favorited", variantId: params[:variantId], favorite: true, favoriteId: @favorite.id  }.to_json
  		end
  	end
  end

  def individual_product_destroy
    @user = spree_current_user
    if params[:variantId]
      @favorite = Favorite.where({user_id: @user.id, variant_id: params[:variantId]}).flatten.first
      if @favorite.delete
        render json: { success_message: "item has been un-favorited", variantId: params[:variantId], favorite: false }.to_json
      end
    end
  end

  def destroy
    @user = spree_current_user
    if params[:favoriteId]
      @favorite = Favorite.find params[:favoriteId]
      if @favorite.delete
        render json: { success_message: "item has been un-favorited", variantId: params[:variantId], favorite: false }.to_json
      end
    end
  end

end