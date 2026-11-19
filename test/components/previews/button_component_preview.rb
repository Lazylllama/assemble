# frozen_string_literal: true

# Mirrors the Figma Button frame (node 203:227): every style in every state.
# Hover can't be shown statically, so only Default and Disabled are here.
class ButtonComponentPreview < ViewComponent::Preview
  STYLES = %i[primary secondary ghost danger text].freeze
  STATES = { "Default" => false, "Disabled" => true }.freeze

  def all_variants
    render_with_template(locals: { styles: STYLES, states: STATES })
  end
end
