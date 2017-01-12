module Spree
  class BytController < Spree::StoreController
    include Spree
    include DeviseHelper
    include ApplicationHelper

  	respond_to :json
    before_filter :check_format, except: [:index, :create_event_for_look, :update_event_for_look, :keyword_search ]

    def index
      page = (params && params[:page] )|| 1
      per_page = (params && params[:per_page] )|| 12
      if params[:search]
        @variants = Spree::Variant.includes(:product).filter_variants(params[:search], nil, params)
        @variants_count = @variants.flatten.count
        @variants = Kaminari.paginate_array(  @variants.flatten  ).page( page ).per(per_page) unless @variants.blank?
      else
        searcher_params = params.clone
        searcher_params.delete :page
        @variants_count = VARIANT_COUNT
        @searcher = build_searcher(searcher_params.merge(include_images: true))
        @variants = @searcher.retrieve_products.map { |p| p.variants.includes(:product) }.flatten.sort_by(&:designer_sort)
      end 
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      respond_to do |format|
        format.html do
          unless @variants.blank?
            @variants = Kaminari.paginate_array( @variants ).page(params[:page] || 1 ).per(per_page)
          end
        end
        format.json do
          render json: @variants, each_serializer: Spree::VariantSerializer, root: "variants", meta: { total_records: @variants_count }
        end
      end  
    end

    def show_variant
      @variant = Spree::Variant.find(params[:variant_id])
      render json: @variant, serializer: Spree::VariantSerializer, root: "variant"
    end

    def keyword_search
      page = (params && params[:page] )|| 1
      per_page = (params && params[:per_page] )|| 12
      if params[:search] && params[:search][:keyword]
        @variants = Spree::Variant.search_variants(keyword: params[:search][:keyword] ).sort_by{ |v| [v.product.catalog_position, v.designer_sort] }
        @variants_count = @variants.flatten.count
        @variants = Kaminari.paginate_array( @variants ).page(params[:page] || 1 ).per(per_page)
        render json: @variants, each_serializer: Spree::VariantSerializer, root: "variants", meta: { total_records: @variants_count }
      end
    end

    def show
      @user = spree_current_user
      @look = Look.find(params[:id])
      render json: { look: @look }.to_json
    end

    def create
      # user is logged in

      if spree_current_user.present?
        @user = spree_current_user
        if params[:look_id].present?
          @look = Look.find params[:look_id]
          @look.update(look_attrs(look_params(@user)))
        else
          @look = Look.new(look_attrs(look_params(@user)))
        end
        if @look.save
          # added new look to current user
          @user.looks << @look
          @user.save
          # exisiting event?
          if params[:event_id].present?
            @event = Event.find params[:event_id]
            @look.event = @event
            @look.save
            render status: :ok, json: { status: 200, success: true, look_id: @look.id, redirect: "/catalog/account" }.to_json
          # need to add an event?
          else
            render status: :ok, json: { status: 320, success: true, look_id: @look.id, redirect: "/events/select?look_id=#{@look.id}" }.to_json
          end  
        else
          @errors = @look.errors.full_messages
          render json: { errors: @errors }.to_json
        end
      
      #user is not logged in
      else
        @look = Look.new(look_attrs(look_params(nil)))
        if @look.save
          render status: :ok, json: { status: 320, success: true, look_id: @look.id, redirect: "/catalog/login?after_login_redirect=events/select&look_id=#{@look.id}" }.to_json
        else
          @errors = @look.errors.full_messages
          render json: { errors: @errors }.to_json
        end
      end  
    end

    def update
      @user = spree_current_user
      @look = Look.find(params[:id])
      if @look.update(look_attrs(look_params(@user)))
        render status: :ok, json: { status: 200, success: true, look_id: @look.id, redirect: "/catalog/account" }.to_json
      else
        @errors = @look.errors.full_messages
        render json: { errors: @errors }.to_json
      end
    end

    def clone
      @user = spree_current_user
      @look = Look.find(params[:look_id])
      @clone = Look.new(clone_look(@look))
      if @clone.save
        render json: { clone: @clone }.to_json
      else
        @errors = @clone.errors.full_messages
        render json: { errors: @errors }.to_json
      end
    end

    def destroy
      @user = spree_current_user
      @look = Look.find(params[:id])
      if @look.destroy
        message = "your look has been deleted."
        render json: { message: message }.to_json
      else
        @errors = @clone.errors.full_messages
        render json: { errors: @errors }.to_json
      end
    end

    def colors
      render json: { colors: COLOR_FILTER }
    end

    def search_colors
      if params[:search] && params[:search][:color]
        @parent_colors = ParentColor.ransack(name_cont: params[:search][:color]).result.flatten
        if @parent_colors.count > 0
          @colors = ChildColor.where parent_color_id: @parent_colors[0].id
        else
          @colors = []
          @colors << ChildColor.ransack(name_cont: params[:search][:color]).result
          @colors << CompetitorColor.ransack(name_cont: params[:search][:color]).result
        end
        @colors = @colors.flatten.compact.uniq 
        render json: @colors.to_json
      end
    end

    def find_parent
      @parent = ParentColor.find params[:search][:parent_color_id]
      render json: @parent
    end

    def filters_by_taxon
      if params[:taxon_id]
        @taxon = Spree::Taxon.find params[:taxon_id]
        @filters = set_filters(taxon: @taxon)
        render json: { filters: @filters }.to_json
      else
        # errors?
      end
    end

    def create_event_for_look

      @user = spree_current_user
      @look = Look.find(params[:event][:look_id])
 
      @event = Event.new(event_params)
      @event.look = @look
      @event.look.save

      if @event.save 
        @user.events << @event
        @user.save
        render json: { redirect: "/catalog/account" }.to_json
      else
        @errors = @event.errors.full_messages
        render json: { errors: @errors }.to_json
      end
    end

    def update_event_for_look
      @event = Event.find params[:id]
      @look = Look.find params[:look_id]
      @event.look = @look
      if @event.save && @event.look.save
        render json: { redirect: "/catalog/account" }.to_json
      else
        @errors = "Unable to save your look. Please try again."
        render json: { errors: @errors }.to_json
      end
    end

    private 

    def check_format
      render :nothing => true, :status => 406 unless params[:format] == 'json'
    end

    def look_params(user)
      params.permit(:id, :look_id, :taxon_id, :format, :event_id, products: [:coatandpants, :tie, :vestandcummerbund, :shirt,:shoes,:socks,:accessories] )
    end

    def event_params
      params.require(:event).permit!
    end

    def look_attrs(look_params)
      look_attrs = look_params.clone
      look_attrs.delete :taxon_id
      look_attrs.delete :format
      if look_attrs["user_id"].present?  
        look_attrs["user_id"] = spree_current_user.id
      else
        look_attrs["user_id"] = nil
      end
      return look_attrs
    end

    def clone_look(look)
      clone = look.clone
      clone.id = nil
      return clone.attributes
    end
  end
end