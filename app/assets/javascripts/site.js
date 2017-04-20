
var refreshRating = function(){
	$('.rating').raty({path: '/assets', scoreName: 'comment[rating]'});
	$('.rated').raty({path: '/assets',
		readOnly: true,
		score: function(){
			return $(this).attr('data-score');
		}
	}); //Raty Plugin
};

$(document).on('turbolinks:load ajaxSuccess', function(){
	refreshRating(); // Raty Plugin Call
	
	$('.img-zoom').elevateZoom(); //Elevate Zoom Plugin
});
