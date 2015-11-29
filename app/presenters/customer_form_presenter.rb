class CustomerFormPresenter < FormPresenter

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name1, label_text, options)
      m << text_field(name1, options.merge(required: false))
      m << text_field(name2, options.merge(required: false))
      m << error_messages_for(name1)
      m << error_messages_for(name2)
    end
  end

  def check_boxes
    markup(:div, class: 'input-block') do |m|
      m << check_box(:suspended)
      m << label(:suspended, 'アカウント停止')
    end
  end
  def parent_and_child_field_block
    markup(:div, class:'input_block') do |m|
      m << decorated_label(:parent_and_child, '親子区分')
      m << radio_button(:parent_and_child,'親')
      m << label(:parent_and_child_parent,'親')
      m << radio_button(:parent_and_child,'子')
      m << label(:parent_and_child_child,'子')
    end
  end
end
