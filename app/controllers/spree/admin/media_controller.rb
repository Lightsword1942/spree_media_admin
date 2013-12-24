# this clas was inspired (heavily) from the mephisto admin architecture
module Spree
  module Admin
    class MediaController < Spree::Admin::BaseController
      #todo, add rss feed of information that is happening
      respond_to :js

      def index
      	@wrapper_class = "image-gallery"
        @images = Image.page(params[:page] || 1)
                       .per(params[:per_page] || 15)
                       .where("attachment_file_name like ?", "%#{params[:query]}%")
      end

      def edit
        @image = Spree::Image.find(params[:id])
      end

      def update
        @image = Spree::Image.find(params[:id])
 
        @image.assign_attributes(params[:image])
        should_reprocess = @image.crop_changed? 
          
        if not @image.save
          flash[:notice] = "Failed to update image"
        else
          @image.attachment.reprocess! if should_reprocess
        end

        render :action => 'edit'
      end

    end
  end
end
