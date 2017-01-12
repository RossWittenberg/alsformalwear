module Spree	
	module Admin
		class ContentsController < BaseController
  	include Spree

  		helper 'spree/admin/navigation'

			def index
				@header_text = "Content Dashboard"
		    respond_to do |format|
		      format.html {render :layout => 'spree/admin/layouts/admin' }
		    end
			end

			def new
				@content = Content.new
			end

			def create 
				@content = Content.new(content_params)
				if @content.save
					flash[:success] = "New Content Added"
					redirect_to :admin_contents
				else
					@errors = @content.errors
					flash[:error] = @errors.full_messages[0]
					redirect_to '/catalog/admin/contents/new'
				end
			end

			def edit
				@content = Content.find params[:id]
				@header_text = "Edit Content"
			end

			def update
				@content = Content.find params[:id]
				if @content.update_attributes(content_params)
					if params[:delete_image]
						@content.image.clear
						@content.image.destroy
						@content.save
					end
					flash[:success] = "Content Updated"
					redirect_to "/catalog/admin/contents/#{@content.id}/edit"
				else
					@errors = @content.errors
					flash[:error] = @errors.full_messages[0]
					redirect_to "/catalog/admin/contents/#{@content.id}/edit"
				end
			end

			def global
				@text_contents = Content.where(page: "global", content_type: "text").order(:description)
				@image_contents = Content.where(page: "global", content_type: "image").order(:description)
				@link_contents = Content.where(page: "global", content_type: "link").order(:description)
				@header_text = "Global Content"
			end

			def home
				@text_contents = Content.where(page: "home", content_type: "text").order(:description)
				@image_contents = Content.where(page: "home", content_type: "image").order(:description)
				@link_contents = Content.where(page: "home", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "home", content_type: "meta-data").order(:description)
				@header_text = "Home Page Content"
			end

			def wedding
				@text_contents = Content.where(page: "wedding", content_type: "text").order(:description)
				@image_contents = Content.where(page: "wedding", content_type: "image").order(:description)
				@link_contents = Content.where(page: "wedding", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "wedding", content_type: "meta-data").order(:description)
				@header_text = "Wedding Page Content"
			end

			def prom
				@text_contents = Content.where(page: "prom", content_type: "text").order(:description)
				@image_contents = Content.where(page: "prom", content_type: "image").order(:description)
				@link_contents = Content.where(page: "prom", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "prom", content_type: "meta-data").order(:description)
				@header_text = "Prom/Formal Page Content"
			end

			def social_event
				@text_contents = Content.where(page: "social-event", content_type: "text").order(:description)
				@image_contents = Content.where(page: "social-event", content_type: "image").order(:description)
				@link_contents = Content.where(page: "social-event", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "social-event", content_type: "meta-data").order(:description)
				@header_text = "Social Events Page Content"

			end

			def quinceanera
				@text_contents = Content.where(page: "quinceanera", content_type: "text").order(:description)
				@image_contents = Content.where(page: "quinceanera", content_type: "image").order(:description)
				@link_contents = Content.where(page: "quinceanera", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "quinceanera", content_type: "meta-data").order(:description)
				@header_text = "Quinceanera Page Content"
			end

			def about
				@text_contents = Content.where(page: "about", content_type: "text").order(:description)
				@image_contents = Content.where(page: "about", content_type: "image").order(:description)
				@link_contents = Content.where(page: "about", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "about", content_type: "meta-data").order(:description)
				@header_text = "About Page Content"
			end

			def contact
				@text_contents = Content.where(page: "contact", content_type: "text").order(:description)
				@image_contents = Content.where(page: "contact", content_type: "image").order(:description)
				@link_contents = Content.where(page: "contact", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "contact", content_type: "meta-data").order(:description)
				@header_text = "Contact/FAQ Page Content"
			end

			def group_offers
				@text_contents = Content.where(page: "group_offers", content_type: "text").order(:description)
				@image_contents = Content.where(page: "group_offers", content_type: "image").order(:description)
				@link_contents = Content.where(page: "group_offers", content_type: "link").order(:description)
				@meta_contents = Content.where(page: "group_offers", content_type: "meta-data").order(:description)
				@header_text = "Group Offers Page Content"
			end

			def other
				@meta_contents = Content.where(page: "other", content_type: "meta-data").order(:description)
				@header_text = "Other Page Content"
			end

			private
		  def content_params
		    params.require(:content).permit!
		  end

		end
	end
end
