module QuoteListsHelper
  def add_quote_link(form_builder)
    output = image_tag('add.png', :size => '16x16')
    output += link_to_function 'add quote', nil, :id => "add_quote_link" do |page|
      form_builder.fields_for :quotes, @quote_list.quotes.build, :child_index => 'REPLACE_ME' do |f|
        page << "$('#quote_fields').append('#{escape_javascript(render( :partial => 'quote_lists/quote_fields', :locals => { :form => f }))}'.replace(/REPLACE_ME/g, new Date().getTime()))"
      end
    end
    return output
  end
  
  def remove_quote_link(form_builder)
    if form_builder.object.new_record?
      link_to_function(image_tag('fail.png', :size => "16x16") + 'Remove', "$(this).parent('.quote').remove();")
    else
      form_builder.hidden_field(:_delete) + 
      link_to_function(image_tag('fail.png', :size => "16x16") + 'Remove', "if (confirm('Are you sure?')) { $(this).parent('.quote').hide(); $(this).prev('input').attr('value', 1) }")
    end
  end
end
