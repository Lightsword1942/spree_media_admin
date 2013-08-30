# this clas was inspired (heavily) from the mephisto admin architecture
module Spree
  module Admin
    class MediaController < Spree::Admin::BaseController
      #todo, add rss feed of information that is happening

      def index
      	@wrapper_class = "image-gallery"
        @images = Image.all
      end

    end
  end
end
