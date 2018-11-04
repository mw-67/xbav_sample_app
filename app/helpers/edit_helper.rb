module EditHelper
  def edit_heading(instance)
    pre = instance.persisted? ? 'Edit ' : 'New '
    pre + instance.class.name
  end

  def edit_form(instance)
    form_for(instance) do |form|
      content = instance.class.attribute_types.map do |name, type|
        next if ['id', 'created_at', 'updated_at', 'ctoken', 'identifier', 'identity'].include?(name)
        content_tag('dt', name) +
          content_tag('dd', edit_input_field(form, name))
      end.compact.join('').html_safe + form.submit
      content_tag('dl', content)
    end
  end

  def edit_input_field(form, name)
    if name =~ /_id/
      edit_dependency(form, name)
    else
      edit_text_field(form, name)
    end
  end

  def edit_text_field(form, name)
    form.text_field(name)
  end

  def edit_dependency(form, name)
    klass = name.sub('_id', '').camelize.constantize
    form.select(name, klass.order(:id).all.map { |instance| [instance.name, instance.id] })
  end
end
