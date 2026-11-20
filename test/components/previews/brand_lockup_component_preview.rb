# frozen_string_literal: true

class BrandLockupComponentPreview < ViewComponent::Preview
  def default
    render(BrandLockupComponent.new)
  end
end
