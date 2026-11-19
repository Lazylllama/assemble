# frozen_string_literal: true

class BadgeComponentPreview < ViewComponent::Preview
  def default
    render(BadgeComponent.new.with_content("67"))
  end
end
