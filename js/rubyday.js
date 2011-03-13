tweets = new Array();

$.ajax({
	url: 'http://search.twitter.com/search.json?q=%23rubyday',
	type: 'GET',
	dataType: 'jsonp',
	complete: function(xhr, textStatus) {
	},
	success: function(data, textStatus, xhr) {
		$.each(data.results, function(index, val) {
			tweet = {
				"from" 		: val.from_user,
				"avatar"	: val.profile_image_url,
				"text"		: val.text,
				"timestamp"	: val.created_at,
				"id"		: val.id_str
			};
			img = "<img src='" + val.profile_image_url + "' alt='" + val.from_user + "' />";
			p = "<p>" + val.text + "</p>";
			time = "<span>" + normalizeDate(val.created_at) + "</span>";
			$('aside > ul').append('<li>' + img + p + time + '</li>');
		});
	},
	error: function(xhr, textStatus, errorThrown) {
		console.log("error");
	}
});

// updateTweets = function(index) {
// 	$tweet = $('.tweets > .tweet');
// 	$tweet.fadeOut(400, function(){
// 		$tweet.find('.text > img').attr({
// 		  src: tweets[index].avatar,
// 		  alt: tweets[index].from
// 		});
// 		$tweet.find('.text > p').text(tweets[index].text);
// 		$tweet.find('.status > a.from').attr('href', 'http://twitter.com/'+tweets[index].from).text(tweets[index].from);
// 		$tweet.find('.status > a.created').attr('href', 'http://twitter.com/'+tweets[index].from+'/status/'+tweets[index].id).text(normalizeDate(tweets[index].timestamp));
// 		$tweet.fadeIn(400, function() {
// 			setTimeout(function(){
// 					updateTweets((index+1)%tweets.length)
// 				}, 5000);
// 		});
// 	});
// }

normalizeDate = function(time) {
	var values = time.split(" ");
	time = values[2] + " " + values[1] + ", " + values[3] + " " + values[4];
	var parsed_date = Date.parse(time);
	var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
	var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
		 delta = delta + (relative_to.getTimezoneOffset() * 60);

	var out = '';
	if (delta < 60) {
		out = 'a minute ago';
	}
	else if(delta < 120) {
		out = 'couple of minutes ago';
	}
	else if(delta < (45*60)) {
		out = (parseInt(delta / 60)).toString() + ' minutes ago';
	}
	else if(delta < (90*60)) {
		out = 'an hour ago';
	}
	else if(delta < (24*60*60)) {
		out = '' + (parseInt(delta / 3600)).toString() + ' hours ago';
	}
	else if(delta < (48*60*60)) {
		out = '1 day ago';
	}
	else {
		out = (parseInt(delta / 86400)).toString() + ' days ago';
	}
		return out;
}