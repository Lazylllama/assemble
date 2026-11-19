# frozen_string_literal: true

# Mirrors the variants on the Figma Button frame. Each public method is one
# example, shown on the UI tester page and at /rails/view_components.
class ButtonComponentPreview < ViewComponent::Preview
  def primary
    render ButtonComponent.new(style: :primary).with_content("Skicka anmälan")
  end

  def secondary
    render ButtonComponent.new(style: :secondary).with_content("Skicka anmälan")
  end

  def ghost
    render ButtonComponent.new(style: :ghost).with_content("Skicka anmälan")
  end

  def danger
    render ButtonComponent.new(style: :danger).with_content("Skicka anmälan")
  end

  def text
    render ButtonComponent.new(style: :text).with_content("Skicka anmälan")
  end

  def disabled
    render ButtonComponent.new(disabled: true).with_content("Skicka anmälan")
  end

  def as_link
    render ButtonComponent.new(style: :ghost, href: "#").with_content("Tillbaka")
  end

  def block
    render ButtonComponent.new(size: :block, class: "w-90").with_content("Skicka anmälan")
  end

  def block_disabled
    render ButtonComponent.new(size: :block, disabled: true, class: "w-90").with_content("Skicka anmälan")
  end
end
