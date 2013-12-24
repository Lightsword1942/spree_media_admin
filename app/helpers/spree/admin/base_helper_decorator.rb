Spree::Admin::BaseHelper.class_eval do 

  def associated_image(image)
    capture do 
      content_tag :div ,:class => "associated-image", "data-id" => image.id do 
        concat(content_tag :div, raw("&times;"), :class => "delete" )
        concat(image_tag(image.attachment.url(:small)))  
      end
    end
  end

  def associated_images(images)
    capture do 
      concat(content_tag(:div, :class => 'associated-images'){
        images.each{|image| concat(associated_image(image))}
      })
    end 
  end

  def media_select_field(form, name)
    capture do 
      concat link_to(t(:select_media), admin_media_path, :class => "select-media-button button")
      concat form.select(
        name, 
        options_for_select(form.object.send(name), form.object.send(name)),
        {}, 
        :multiple => true,
        :class => 'associated-image-ids'
      )
      concat associated_images(form.object.send(name.to_s.gsub("_ids","").pluralize).all)
    end 
  end

  def attachment_url(attachment, style)
    URI.join(request.url, attachment.url(style))
  end
end