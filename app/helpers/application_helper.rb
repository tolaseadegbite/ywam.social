module ApplicationHelper
  def render_category_fields(form, resource)
    return unless resource.resource_category
    
    category_name = resource.resource_category.name.downcase
    partial_name = "resources/category_fields_#{category_name}"
    
    if lookup_context.template_exists?(partial_name, [], true)
      render partial: partial_name, locals: { form: form, resource: resource }
    else
      content_tag(:p, "No specific fields for this category.")
    end
  end
end