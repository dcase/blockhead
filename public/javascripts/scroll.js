function getTop() {
	// get the top of the content
	var top = $('#scroll-content').css('top');
	return trimPx(top);
}

function getHeight(id) {
	// get the height, including padding
	var height = $(id).height();
	var paddingTop = trimPx($(id).css("padding-top"));
	var paddingBottom = trimPx($(id).css("padding-bottom"));

	return height + paddingTop + paddingBottom;
}

function trimPx(value) {
	// remove "px" from values
	var pos = value.indexOf("px");
	if (pos != 0)
		return parseInt(value.substring(0, pos));
	else
		return 0;
}

var container;
var content;
var hidden;	// # of pixels hidden by the container

function setScrollerDimensions() {
	container = getHeight("#scroll-container");
	content = getHeight("#scroll-content");
	hidden = content - container;
}

function resetScroller() {
	setScrollerDimensions();
	$('#scroll-content').css('top', 0);
}

$(document).ready( function() {
	setScrollerDimensions();
})