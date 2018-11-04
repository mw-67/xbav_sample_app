module DisplayHelper
  def heading(presenter, plural: false)
    heading = presenter.name.sub('Presenter', '')
    if plural
      heading = heading.pluralize
    end
    heading
  end

  def header_row(presenter)
    presenter.fields.map do |field, opts|
      content_tag(:th, display_label(field, opts))
    end.join("\n").html_safe
  end

  def model_row(model, presenter: nil)
    presented = present_for_display(model, presenter: presenter)
    presented.class.fields.map do |field, opts|
      content_tag(:td, display_value(presented, field, opts))
    end.join("\n").html_safe
  end

  def new_link(presenter)
    link_to 'New', send('new_' + presenter.instance_path_method.to_s)
  end

  def edit_link(model, presenter: nil)
    presented = present_for_display(model, presenter: presenter)
    link_to 'Edit', send('edit_' + presented.class.instance_path_method.to_s, id: presented.id)
  end

  def delete_link(model, presenter: nil)
    return unless model.deletable?

    presented = present_for_display(model, presenter: presenter)
    link_to 'Delete', send(presented.class.instance_path_method.to_s, id: presented.id), method: :delete
  end

  def instance_table(instance, presenter: nil)
    presented = present_for_display(instance, presenter: presenter)
    presented.class.fields.map do |field, opts|
      content_tag(:tr) do
        content_tag(:td, display_label(field, opts)) +
        content_tag(:td, display_value(presented, field, opts))
      end
    end.join("\n").html_safe
  end

  private

  def display_label(field, opts)
    opts[:label] || field
  end

  def present_for_display(model, presenter: nil)
    presenter ||= begin
                    klass = model.class.name + "Presenter"
                    Kernel.const_get(klass)
                  end
    presenter.new(model)
  end

  def display_value(presented, field, opts)
    value = presented.send(field)
    if value.is_a? Array
      value = value.map {|entry| h(entry) }.join('<br/>').html_safe
    else
      value = h(value)
    end

    if opts[:link]
      value = link_to(value, presented.send(opts[:link], self))
    elsif field == :id
      value = link_to(value, send(presented.class.instance_path_method, id: presented.id))
    end
    value
  end
end
