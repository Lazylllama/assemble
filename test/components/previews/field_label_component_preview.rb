# frozen_string_literal: true

class FieldLabelComponentPreview < ViewComponent::Preview
  def default
    render(FieldLabelComponent.new.with_content("Address"))
  end

  def optional
    render(FieldLabelComponent.new(optional: true).with_content("Telefonnummer"))
  end
end
