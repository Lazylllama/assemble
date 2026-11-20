# frozen_string_literal: true

class FieldErrorComponent < ViewComponent::Base
  include ClassVariants::Helper

  class_variants do
    base do
      slot :default, class: "flex items-start gap-2 text-magenta-t font-sans text-t3 font-semibold leading-5"
      slot :glyph, class: "inline-flex h-5 w-3 justify-center items-center shrink-0"
    end
  end

  def initialize(**html_attributes)
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(class: @extra_class)
  def glyph_classes = class_variants(:glyph)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
