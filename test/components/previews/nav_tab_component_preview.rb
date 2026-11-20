# frozen_string_literal: true

class NavTabComponentPreview < ViewComponent::Preview
  VARIATIONS = [
    { label: "Not Current" },
    { label: "Current", current: true },
    { label: "Badge Not Current", badge: "1" },
    { label: "Badge Current", current: true, badge: "1" }
  ].freeze

  def all_variations
    render_with_template(locals: { variations: VARIATIONS })
  end
end
