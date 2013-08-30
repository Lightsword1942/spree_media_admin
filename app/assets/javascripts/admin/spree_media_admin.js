//= require admin/spree_backend
//= require jquery.imagesloaded
//= require jquery.wookmark

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
});

