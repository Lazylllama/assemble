# frozen_string_literal: true

class PaneComponentPreview < ViewComponent::Preview
  TONES = PaneComponent::GLYPH.keys.freeze

  def all_variants
    render_with_template(locals: { tones: TONES })
  end
end
