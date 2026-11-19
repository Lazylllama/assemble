# frozen_string_literal: true

class StatusGlyphComponentPreview < ViewComponent::Preview
  def all_variants
    kinds = StatusComponent::KINDS.freeze

    render_with_template(locals: { kinds: kinds })
  end
end
