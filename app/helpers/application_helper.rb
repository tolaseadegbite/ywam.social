module ApplicationHelper
    def render_category_fields(form, resource)
      return unless resource.resource_category
      
      category_name = resource.resource_category.name.downcase
      render partial: "resources/category_fields_#{category_name}", locals: { form: form, resource: resource }
    rescue ActionView::MissingTemplate
      content_tag(:p, "No specific fields for this category.")
    end
  end