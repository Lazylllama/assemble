# frozen_string_literal: true

class FieldHintComponentPreview < ViewComponent::Preview
  def default
    render(FieldHintComponent.new.with_content("This is a hint for the field."))
  end
end
