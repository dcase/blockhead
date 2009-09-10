// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Declare any global variables
var modal_trigger;
var edit_in_place_trigger;
var original_content;
var modal_tabs;
var modal;
var modal2;

// rails auth token enabled in jquery
$(document).ajaxSend(function(event, request, settings) {
  if (settings.type == 'GET' || settings.type == 'get' || typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")},
	cache : false
})

$.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};



// Page specific stuff

$(document).ready( function() {
	
	// Show admin controls on menu item hover
	$('.list li, .quote_list li, #mainmenu > li, .blog_posts li').livequery( function() {
		 $(this).hover( 
			function() {
				$('> .menu_item_admin_controls',this).show();
			},
			function(){
				$('> .menu_item_admin_controls',this).hide();
			}
		);
	});
	
	// Fade the alerts so they're not so distracting
	$("#alert").fadeTo("slow", 0.5);
	
	// Setup modals
	
	$('body').append('<div id="modal"><img id="modal-close" src="/images/modal_button_close.png" width="30" height="30" alt="Close Window" /><div id="modal-content"></div></div>');
	
	
	// Main modal window
	modal = $('#modal').jqm({
		modal: true,
		ajax: '@href',
		ajaxText: "<h1>Loading...</h1>",
		target: '#modal-content',
		onLoad: function(hash) {
			modal_trigger = $(hash.t);
		}
	});
	$('#modal').jqmAddClose('#modal-close');
	$('.modal').livequery( function(){
		$('#modal').jqmAddTrigger('.modal');
	});
	
	// Add second window, if needed
	$('.modal-new-window').livequery( function() {
		if ( $('#modal2').length == 0) {
			$('body').append('<div id="modal2"><img id="modal-close2" src="/images/modal_button_close.png" width="30" height="30" alt="Close Window" /><div id="modal-content2"></div></div>');
			modal2 = $('#modal2').jqm({
				modal: true,
				ajax: '@href',
				ajaxText: "<h1>Loading...</h1>",
				target: '#modal-content2',
				onLoad: function(hash) {
					modal2_trigger = $(hash.t);
				}
			});
			$('#modal2').jqmAddClose('#modal-close2');
		}
		$('#modal2').jqmAddTrigger('.modal-new-window');
	});

	
	// Add toggle for page section fields
	$('.toggle_fieldset').livequery('click', function(event) {
		$(this).parent().next('fieldset').toggle();
		});
	
	// Ajaxify forms

	$('form.ajax').livequery( function(){
		if ($(this).parent().hasClass(".ui-tabs-panel")) {
			is_tab = true;
			current_window = $(this).parent();
			current_modal = modal;
			current_trigger = modal_trigger;
		}
		else if ($(this).hasClass("modal2")) {
			is_tab = false;
			current_modal = modal2;
			current_window = $('#modal-content2');
			current_trigger = modal2_trigger;
		} else {
			is_tab = false;
			current_modal = modal;
			current_window = $('#modal-content');
			current_trigger = modal_trigger;
		}
		if ( $(this).attr('enctype') == "multipart/form-data") {
			if ($('#ajax-target').length == 0 ) {
				$('body').append('<iframe id="ajax-target" name="ajax-target" style="display:none;"></iframe>');
			}
			$(this).attr({'target':'ajax-target','action':$(this).attr('action') + '.js'});
		} else {
			$(this).bind('submit', function(event) {
				$.post(
					$(this).attr('action'),
					$(this).serialize(),
					function(data) {
						if ($('#errorExplanation',data).length > 0 ) {
							current_window.html(data);
						} else {
							class_names = current_trigger.attr('class').split(" ");
							update_class = $.grep(class_names, function(c) {  return c.substr(0,6) == "update"});
							append_class = $.grep(class_names, function(c) {  return c.substr(0,6) == "append"});
							if ( update_class.length > 0) {
								update_id = update_class[0].substr(7);
								$('#' + update_id + ", ." + update_id).replaceWith(data);
								current_window.html("");
								current_modal.jqmHide();
							}
							else if ( append_class.length > 0 ) {
								append_id = append_class[0].substr(7);
								$('#' + append_id + ", ." + append_id).append(data);
								current_window.html("");
								current_modal.jqmHide();
							}
							else {
								current_window.html(data);
								$('#modal-content2').html("");
								$('#modal2').jqmHide();
							}
						}
					},
					"html"
				);
			event.preventDefault();
			});
		}
	});
	
	// Ajaxify links by method
	$('a.ajax-delete').livequery('click', function(event) {
	        if ( confirm("Are you sure you want to delete this?") ) {
	            $.post(
	                $(this).attr('href'),
	                { '_method': 'delete' },
	                null,
	                "script" 
	            );
			}
	       event.preventDefault();
	});
	
	// Make Admin Toolbar draggable
	$('#admin-toolbar-container').draggable({ handle: '.admin_drag_handle'});
	
	// Make Textile links open in new window
	$('.textile a').attr('target','_blank');
	
	// Create tabbed modal window
	$(".modal-tabs").livequery( function() {
		modal_tabs = $(this).tabs();
	});
	
	// Create tabbed nested blocks
	$('.nested_block_tabs').livequery( function() {
		if ($('div.block', this).length > 0) {
			$(this).tabs();
		}
	})
	// Load selected content form
	$("#new_content_chooser").livequery("change", function(event) {
		$('#new_content_chooser_link').attr('href', function() {
			param = /[\\?&]content_controller=([^&#]*)/.exec($(this).attr('href'));
			return $(this).attr('href').replace(new RegExp(param[1]),$("#new_content_chooser option:selected").val());
		});
	});
	
	// Update with selected content form
	$("#new_content_chooser_link").livequery("click", function(event) {
		$.get(
        $(this).attr('href'),
        { },
        function(data) {
					$('#content_form_container').html(data);
				},
        "html" 
    	);
			 event.preventDefault();
	});
	
	// Load selected content form
	$("#existing_content_chooser").livequery("change", function(event) {
		$('#existing_content_link').attr('href', function() {
			param = /[\\?&](add_content_id=[^&#]*)/.exec($(this).attr('href'));
			return $(this).attr('href').replace(new RegExp(param[1]),"add_content_id="+$("#existing_content_chooser option:selected").val());
		});
	});
	
	// Highlights for admin
	
	$("#container .block, #container .content",".admin-mode").livequery( function() {
		$(this).hover(
			function() {
				$(".active-admin").not($(this).parents()).removeClass("active-admin");
				$(".admin-links:visible").hide();
				$(this).addClass("active-admin");
				$("> .admin-links", this).show();
			},
			function() {
				$(".active-admin").not($(this).parents()).removeClass("active-admin");
				$(".admin-links:visible").hide();
				$("> .admin-links", this).hide();
				$(this).parent(".active-admin").children(".admin-links").show();
			});
		});
		
	// Edit in place
	$(".edit_in_place_form").livequery('submit', function(event){
		$.post(
			$(this).attr('action'), 
			$(this).serialize(), 
			function(data) {
				if ($('#errorExplanation',data).length > 0 ) {
					$(this).replaceWith(data);
				} else {
					class_names = edit_in_place_trigger.attr('class').split(" ");
					update_class = $.grep(class_names, function(c) {  return c.substr(0,6) == "update"});
					append_class = $.grep(class_names, function(c) {  return c.substr(0,6) == "append"});
					if ( update_class.length > 0) {
						update_id = update_class[0].substr(7);
						$('#' + update_id + ", ." + update_id).replaceWith(data);
					}
					else if ( append_class.length > 0 ) {
						append_id = append_class[0].substr(7);
						$('#' + append_id + ", ." + append_id).append(data);
					}
					else {
						$(this).replaceWith(data);
					}
				}
			}, 
			"html"
			);
		event.preventDefault();
	});
	
	$(".edit_in_place").livequery( 'click', function(event) {
		edit_in_place_trigger = $(this);
		original_content = edit_in_place_trigger.parent().parent().html();
		
		$.get(
        $(this).attr('href'),
        { },
        function(data) {
					edit_in_place_trigger.parent().parent().html(data);
				},
        "html" 
    	);
			event.preventDefault();
	});
	
	$(".new_in_place_list_item").livequery( 'click', function(event) {
		edit_in_place_trigger = $(this);
		$.get(
        $(this).attr('href'),
        { },
        function(data) {
					edit_in_place_trigger.parents('ul:first, ol:first').append("<li id=\"new_in_place_item\" class=\"list_item\">"+ data + "</li>");
				},
        "html" 
    	);
			event.preventDefault();
	});
	
	$('.cancel_edit_in_place').livequery('click', function(event) {
		$(this).parent().parent().html(original_content);
		event.preventDefault();
	});
	
	$('.cancel_new_in_place').livequery('click', function(event) {
		$('#new_in_place_item').remove();
		event.preventDefault();
	});
	
	// Insert Image File
	$('form#insert_image_file').livequery("change", function(){
		var insert_code, image_url, alt_text, link_url, page_link, align;
		var centered = "";
		
		// Set Image URI
		$('#image_url').val($('#image_url_container input:checked').next().val());
		
		// Set Page URL if there is one
		if($("#page_link").val() != "") {
			$('#image_file_link_url').val($('#page_link').val());
		}
		
		// Image URI
		image_url = $('#image_url').val();
		
		// Alt text
		alt_text = $('#image_file_caption').val();
		if (alt_text.length > 0) {
			alt_text = "(" + alt_text + ")";
		}
		
		// Link URL
		link_url = $('#image_file_link_url').val();
		if (link_url.length > 0) {
			link_url = ":" + link_url;
		}
		
		// Alignment
		switch($('#image_align_container input:checked').val()) {
			case "left":
				align = "<";
			break;
			case "center":
			 align = "";
			 centered = "p=. ";
			break;
			case "right":
			 align = ">";
			break;
			case "none":
			 align = "";
			break;
			default:
				align = "";
			break;
		}
		
		// Put it all together
		insert_code = centered + "!" + align + image_url + alt_text + "!" + link_url;
		
		// Spit it out
		$('form#insert_image_file #output').val(insert_code).focus().select();
	});
	
	$('#generate_image_file_code').livequery("click", function(event) {
		$('form#insert_image_file').trigger("change");
		event.preventDefault();
	});
	
	$('.insert_image_link').livequery('click', function(event) {
		modal_tabs.tabs('url',0,$(this).attr('href'));
		modal_tabs.tabs('select',0);
		event.preventDefault();
		event.stopPropagation();
	});
	
	$('.image_file').livequery('click', function(event) {
		$('.insert_image_link', this).trigger('click');
	});
	
	$('.image_file').livequery( function(event) {
		$(this).hover(
			function() {
				$(this).addClass('image_file_over');
			},
			function() {
				$(this).removeClass('image_file_over');
			});
	});
	
	// Sortable blocks
	$('#main, div.block').not('.nested_block_tabs').livequery( function() {
			$(this).sortable({
				handle: '.block_drag_handle',
				items: 'div.block',
				axis: 'y',
				update: function() {
					$.post('/blocks/order', $(this).sortable('serialize') +'&'+'authenticity_token='+ encodeURIComponent(AUTH_TOKEN));
				} 
			});
		});
		
	// Sortable contents
	$('div.block').livequery( function() {
			$(this).sortable({
				handle: '.content_drag_handle',
				items: 'div.content',
				axis: 'y',
				update: function() {
					$.post('/contents/order', $(this).sortable('serialize') +'&block_id='+ $(this).attr('id').split("_").pop());
				} 
			});
		});
		
	// Resizble blocks
	$(".admin-mode div.block").livequery( function() {
		$(this).resizable({
			containment: "div#main",
			handles: "s",
			minHeight: 50,
			stop: function(event,ui) {
				$.post('/blocks/resize/' + $(this).attr('id').split("_").pop(), ui.size);
				$(this).checkScrolls();
			}
		});
	});
	
	//Reset block height
	$(".reset-block-height").livequery("click", function(event){
		block = $(this).parents(".block:first");
		block.css({ width: "auto", height: "auto"});
		$.post('/blocks/resize/' + block.attr('id').split("_").pop(), "height=&width=");
		$(block).checkScrolls();
		event.preventDefault();
		});
		
	// Automatic scroll buttons	
	$.fn.checkScrolls = function() {
		this.each( function() {
			if ($('> .scroll-pane', this).length == 0) {
				$('> *',this).not(".admin-links, .scroll-buttons, h4").wrapAll("<div class=\"scroll-pane\" style=\"height: " + $(this).height() + "px;\"></div>").wrapAll("<div class=\"scroll-content\"></div>");
			}
		
			var pane = $('> .scroll-pane', this);
			var content = $('> .scroll-pane .scroll-content', this);
		
			if (pane.height() < content.height()) {
				$('> .scroll-buttons .scroll-down', this).mousedown( function() {
						$(this).parent().siblings('.scroll-pane').scrollTo('max', "slow", {easing: 'linear'});
					}).mouseup( function() {
						$(this).parent().siblings('.scroll-pane').stop();
					}
				);

				$('> .scroll-buttons .scroll-up', this).mousedown( function() {
						$(this).parent().siblings('.scroll-pane').scrollTo(0, "slow", {easing: 'linear'});
					}).mouseup( function() {
						$(this).parent().siblings('.scroll-pane').stop();
					}
				);

				pane.scrollTo(0,0);
				pane.css('padding-right', '30px');
				$('> .scroll-buttons', this).show();
			} else {
				pane.replaceWith(content.html());
				$('> .scroll-buttons', this).hide();
				$('> .scroll-buttons .scroll-up, > .scroll-buttons .scroll-down', this).unbind();
			}
		});
	}
	
	$('.block.autoscroll,.content.autoscroll').livequery( function() {
		$(this).checkScrolls();
	});
	
	// Font size switcher
	function switchTextSize(size, trigger) {
		$("#font-size-switcher a").removeClass("current");
		$(trigger).addClass("current");
		$(".content").removeClass("small medium large").addClass(size);
		$.post("/contents/remember_text_size", { text_size : size});
		$('.block.autoscroll').checkScrolls();
	}
	$("#small").click( function(event) {
		switchTextSize("small",this);
		event.preventDefault();
	});
	$("#medium").click( function(event) {
		switchTextSize("medium",this);
		event.preventDefault();
	});
	$("#large").click( function(event) {
		switchTextSize("large",this);
		event.preventDefault();
	});
	
	// Sorting main menu
	
	$(".admin-mode #mainmenu, .admin-mode #mainmenu ul").each( function() {
	 	$(this).sortable({ 
			items: "> li", 
			axis: "y", 
			containment: "parent", 
			placeholder: "ui-state-highlight",
			forcePlaceholderSize: true,
			helper: 'clone',
			tolerance: 'pointer',
			update: function(event, ui) {
				$.post('/sections/order', $(ui.item).parent().sortable('serialize'));
			}
		});
	});
	
	// Pagination for Contents browser and ImageFiles browser
	$(".ui-tabs .pagination a").livequery("click", function(event) {
		current_tab  = modal_tabs.data("selected.tabs");
		modal_tabs.tabs('url', current_tab, $(this).attr('href'));
		modal_tabs.tabs('load', current_tab);
		event.preventDefault();
	});
	
	// Focus on login form
	$("#new_user_session input[type=text]:first").focus();
	
	// Quote List
	$(".quote_list > li").livequery("click", function(event) {
		$("#quote_display").html($(".quote_display", this).html());
	});
	
		
});