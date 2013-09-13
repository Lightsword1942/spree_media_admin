module Spree
  class Image < Asset
    validates_attachment_presence :attachment
    validate :no_attachment_errors

    attr_accessible :alt, :attachment, :position, :viewable_type, :viewable_id
    attr_accessible :crop_x, :crop_y, :crop_w, :crop_h

    has_attached_file :attachment,
                      styles: { mini: '48x48>', small: '100x100>', product: '240x240>', large: '600x600>' },
                      default_style: :product,
                      url: '/spree/products/:id/:style/:basename.:extension',
                      path: ':rails_root/public/spree/products/:id/:style/:basename.:extension',
                      convert_options: { all: '-strip -auto-orient' },
                      processors: [:cropper]

    # save the w,h of the original image (from which others can be calculated)
    # we need to look at the write-queue for images which have not been saved yet
    after_post_process :find_dimensions

    include Spree::Core::S3Support
    supports_s3 :attachment

    Spree::Image.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Spree::Config[:attachment_styles]).symbolize_keys!
    Spree::Image.attachment_definitions[:attachment][:path] = Spree::Config[:attachment_path]
    Spree::Image.attachment_definitions[:attachment][:url] = Spree::Config[:attachment_url]
    Spree::Image.attachment_definitions[:attachment][:default_url] = Spree::Config[:attachment_default_url]
    Spree::Image.attachment_definitions[:attachment][:default_style] = Spree::Config[:attachment_default_style]

    #used by admin products autocomplete
    def mini_url
      attachment.url(:mini, false)
    end

    def find_dimensions
      temporary = attachment.queued_for_write[:original]
      filename = temporary.path unless temporary.nil?
      filename = attachment.path if filename.blank?
      geometry = Paperclip::Geometry.from_file(filename)
      self.attachment_width  = geometry.width
      self.attachment_height = geometry.height
    end

    # if there are errors from the plugin, then add a more meaningful message
    def no_attachment_errors
      unless attachment.errors.empty?
        # uncomment this to get rid of the less-than-useful interrim messages
        # errors.clear
        errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
        false
      end
    end

    def crop_changed?
      crop_x_changed? or crop_y_changed? or crop_w_changed? or crop_h_changed?
    end

    def should_crop?
      crop_w > 0 and crop_h > 0
    end

    def file_geometry(style = :original)
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(attachment.path(style))
    end
  end
end
