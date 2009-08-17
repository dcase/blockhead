module ListsHelper
  def add_list_item_link(form_builder)
    output = image_tag('add.png', :size => '16x16')
    output += link_to_function 'add item', nil, :id => "add_list_item_link" do |page|
      form_builder.fields_for :list_items, @list.list_items.build, :child_index => 'REPLACE_ME' do |f|
        page << "$('#list_item_fields').append('#{escape_javascript(render( :partial => 'lists/list_item_fields', :locals => { :form => f }))}'.replace(/REPLACE_ME/g, new Date().getTime()))"
      end
    end
    return output
  end
  
  def remove_list_item_link(form_builder)
    if form_builder.object.new_record?
      link_to_function(image_tag('fail.png', :size => "16x16") + 'Remove', "$(this).parent('.list_item').remove();")
    else
      form_builder.hidden_field(:_delete) + 
      link_to_function(image_tag('fail.png', :size => "16x16") + 'Remove', "if (confirm('Are you sure?')) { $(this).parent('.list_item').hide(); $(this).prev('input').attr('value', 1) }")
    end
  end
end
