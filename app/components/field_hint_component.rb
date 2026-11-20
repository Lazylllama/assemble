# frozen_string_literal: true

class FieldHintComponent < ViewComponent::Base
  include ClassVariants::Helper

  class_variants do
    base do
      slot :default, class: "flex flex-col items-start text-fg-2 font-sans text-t3"
    end
  end

  def initialize(**html_attributes)
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(class: @extra_class)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
