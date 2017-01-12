module Spree	
	module Admin
		class ColorsController < BaseController
  	include Spree

  		helper 'spree/admin/navigation'

			def index
				@header_text = "Colors Dashboard"
				@als_colors = ChildColor.order(:parent_color_id)
				@competitor_colors = CompetitorColor.order(:parent_color_id)
		    respond_to do |format|
		      format.html {render :layout => 'spree/admin/layouts/admin' }
		    end
			end

			def new
				@color = ChildColor.new
				@parent_colors = ParentColor.all
				@header_text = "Add a Color"
			end

			def new_competitor_color
				@color = CompetitorColor.new
				@parent_colors = ParentColor.all
				@header_text = "Add a Color"
			end

			def create 
				if color_params[:parent_color].present?
					color_params[:parent_color] = ParentColor.find color_params[:parent_color].to_i
				else
					flash[:error] = "Please enter a parent color."
					redirect_to redirect_path
				end	
				if params[:als] == "true"
					@color = ChildColor.new(color_params)
					redirect_path = "/catalog/admin/colors/#{@color.id}/edit?als=true"
					if params[:presentation].present?	
						child_color_option_type = Spree::OptionType.find_by_name 'child_color'
						if params[:presentation].blank?
							flash[:error] = "Please enter a presentation name."
							redirect_to redirect_path
						end
						child_color_option_type = Spree::OptionType.find_by_name 'child_color'
						child_color_option_value = Spree::OptionValue.create({name: color_params[:name], presentation: params[:presentation], option_type: child_color_option_type })
					end	
				else
					@color = CompetitorColor.create(color_params)
					redirect_path = "/catalog/admin/colors/#{@color.id}/edit"
				end
				if @color.save
					flash[:success] = "New Color Added"
					redirect_to :admin_colors
				else
					@errors = @color.errors
					flash[:error] = @errors.full_messages[0]
					redirect_to :new_admin_colors
				end
			end

			def edit
				if params[:als] == "true"
					@color = ChildColor.find params[:id]
					spree_option_value = Spree::OptionValue.find_by_name @color.name.downcase.gsub(" ", "_")
					@presentation = spree_option_value.presentation
				else
					@color = CompetitorColor.find params[:id]
				end
				@parent_colors = ParentColor.all
				@header_text = "Edit Color"
			end

			def update
				if params[:als] == "true"
					@color = ChildColor.find params[:id]
					redirect_path = "/catalog/admin/colors/#{@color.id}/edit?als=true"
					if params[:presentation].present?	
						child_color_option_type = Spree::OptionType.find_by_name 'child_color'
						if params[:presentation].blank?
							flash[:error] = "Please enter a presentation name."
							redirect_to redirect_path
						end
						child_color_option_value = Spree::OptionValue.find_by_name color_params[:name]
						child_color_option_value.update_attributes(presentation: params[:presentation])
					end	
				else
					@color = CompetitorColor.find params[:id]
					redirect_path = "/catalog/admin/colors/#{@color.id}/edit"
				end
				if color_params[:parent_color].present?
					color_params[:parent_color] = ParentColor.find color_params[:parent_color].to_i
				end	
				if @color.update_attributes(color_params)
					flash[:success] = "Color Updated"
					redirect_to redirect_path
				else
					@errors = @color.errors
					flash[:error] = @errors.full_messages[0]
					redirect_to redirect_path
				end
			end

			def destroy
				if params[:als] == "true"
					@color = ChildColor.find params[:id]
				else
					@color = CompetitorColor.find params[:id]
				end
				if @color.delete
					flash[:success] = "Color Deleted"
					redirect_to "/catalog/admin/colors"
				end
			end

			def new_competitor_color
				@color = CompetitorColor.new
				@parent_colors = ParentColor.all
				@header_text = "Add a Color"
			end


			private
		  def color_params
		  	if params[:child_color].present?
			    params.require(:child_color).permit! 
			  elsif params[:competitor_color].present?
		    	params.require(:competitor_color).permit!
		    end
		  end
		
		end
	end
end