# frozen_string_literal: true

class KbdComponentPreview < ViewComponent::Preview
  def default
    render(KbdComponent.new.with_content("K"))
  end
end
