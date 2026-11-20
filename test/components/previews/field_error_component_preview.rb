# frozen_string_literal: true

class FieldErrorComponentPreview < ViewComponent::Preview
  def default
    render(FieldErrorComponent.new.with_content("Address is required."))
  end
end
