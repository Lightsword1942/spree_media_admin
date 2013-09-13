//= require admin/spree_backend
//= require jquery.imagesloaded
//= require jquery.wookmark
//= require jquery.fileupload
//= require jquery.color
//= require jquery.Jcrop

$(document).ready(function(){
	$('.images').imagesLoaded(function() {
		$(".images .image").wookmark({
		  // Prepare layout options.
		  autoResize: true, // This will auto-update the layout when the browser window is resized.
		  container: $('.images'), // Optional, used for some extra CSS styling
		  offset: 15, // Optional, the distance between grid items
		  outerOffset: 0, // Optional, the distance to the containers border
		  itemWidth: 220 // Optional, the width of a grid item
		});
	});

  $progressBar = $('.upload-progress .bar')
  $('#media-upload').fileupload({
    dataType: 'json',
    add: function (e, data) {
      $progressBar.css('width','0%');
      $('.page-actions #upload-images').addClass('uploading');
      data.submit();
    },
    done: function (e, data) {
      $('.page-actions #upload-images').removeClass('uploading');
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $progressBar.css('width',progress+'%');
    }
  });

  $('.images').on('click', '.toolbar .delete', function(event){
    $.ajax({
      url: $(event.currentTarget).attr('data-path'),
      type: 'DELETE',
      success: function(result) {
        $(event.currentTarget).parents('.image').remove()
        $('.images').trigger('refreshWookmark');
      }
    });

    return false;
  });

});

