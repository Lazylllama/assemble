# frozen_string_literal: true

class FieldLabelComponent < ViewComponent::Base
  include ClassVariants::Helper

  class_variants do
    base do
      slot :default, class: "flex items-start gap-1.5 font-sans leading-6.5 text-t4 text-fg"
      slot :optional, class: "text-fg-3"
    end
  end

  def initialize(optional: false, **html_attributes)
    @optional = optional
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(class: @extra_class)
  def optional_classes = class_variants(:optional)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
