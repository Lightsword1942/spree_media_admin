$(document).ready(function(){
  $currentMediaGallerySelect = null

  function getImages(url){
    $.getScript(url, function(){
      $currentMediaGallerySelect.find("option").each(function(){
        $(".image[data-id='"+this.value+"']").addClass("selected")
      });
    });
  }

  $(document).on('click', '.select-media-button', function(event){
    $currentMediaGallerySelect = $(event.currentTarget).siblings("select");
    getImages(this.href);
    return false;
  });

  $(document).on('click', '.media-gallery-header .pagination a', function(){
    getImages(this.href);
    return false;
  });
 
  $(document).on('submit', '.media-gallery-header form', function(){
    getImages(this.action+"?"+$(this).serialize());
    return false;
  });

  $(document).on('click', '.media-gallery-popup img', function(event){
    $image = $(event.target).parents('.image');
    $image.toggleClass('selected');

    $(document).trigger('imageSelectionChange', {
      imageId: $image.attr('data-id'), 
      imageUrl: $image.attr('data-small-url'),
      isSelected: $image.hasClass('selected')
    });
    return false;
  });

  function toggleImageOption(data){
    $currentMediaGallerySelect.find("option[value='"+data.imageId+"']").remove();
    if (data.isSelected) {
      $currentMediaGallerySelect.append("<option selected value='"+data.imageId+"'>"+data.imageId+"</option>");
    }
  }

  function toggleImage(data){
    $images = $currentMediaGallerySelect.siblings(".associated-images");
    $images.find(".associated-image[data-id='"+data.imageId+"']").remove();
    if (data.isSelected) {
      $images.append(
        "<div class='associated-image' data-id='"+data.imageId+"'>"+
        "<div class='delete'>&times;</div>"+
        "<img src='"+data.imageUrl+"'></img>"+
        "</div>"
      );
    }
  }

  $(document).on('imageSelectionChange', function(event, data){
    toggleImageOption(data);
    toggleImage(data);
  });  

  $(document).on('click', '.media-gallery-popup', function(event){
    if (event.target == event.currentTarget) {
      $(event.currentTarget.remove());
    };
  });

  $(document).on('click','.close-gallery-button', function(){
    $(this).parents('.media-gallery-popup').remove();
  });

  $(document).on('click', '.associated-image .delete', function(){
    imageId = $(this).parent().attr("data-id");
    $(this).parents(".associated-images")
           .siblings(".associated-image-ids")
           .find("option[value='"+imageId+"']").remove();

    $(this).parent().remove();
  });

  
});
