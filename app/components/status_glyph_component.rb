# frozen_string_literal: true

class StatusGlyphComponent < ViewComponent::Base
  def initialize(kind: :none)
    @kind = kind
  end
end
