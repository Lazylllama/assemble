# frozen_string_literal: true

class StatusComponentPreview < ViewComponent::Preview
  KINDS = StatusComponent::KINDS.freeze

  def all_variants
    render_with_template(locals: { kinds: KINDS })
  end
end
