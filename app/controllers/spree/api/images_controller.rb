module Spree
  module Api
    class ImagesController < Spree::Api::BaseController
      respond_to :json

      def show
        @image = Image.find(params[:id])
        respond_with(@image)
      end

      def create
        authorize! :create, Image
        Rails.logger.info "receiving image with params #{params}"
        @image = Image.create(params[:image])

        if params[:viewable_type] and params[:viewable_id]
          viewable_class = Object.const_get(params[:viewable_type])
          viewable = viewable_class.find(params[:viewable_id].to_i)

          if viewable.respond_to?(:images)
            viewable.images << @image
          else
            @image.viewable = viewable
            @image.save
          end
        end
        respond_with(@image, :status => 201, :default_template => :show)
      end

      def update
        authorize! :update, Image
        @image = Image.find(params[:id])
        @image.update_attributes(params[:image])
        respond_with(@image, :default_template => :show)
      end

      def destroy
        authorize! :delete, Image
        @image = Image.find(params[:id])
        @image.destroy
        respond_with(@image, :status => 204)
      end
    end
  end
end
