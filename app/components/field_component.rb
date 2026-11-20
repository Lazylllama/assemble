# frozen_string_literal: true

class FieldComponent < ViewComponent::Base
   include ClassVariants::Helper

  class_variants do
    base do
      slot :default, class: "flex bg-field gap-3 items-center rounded-xs border border-edge w-full"
    end

    variant type: :text do
      slot :default, class: "h-13 px-3.5"
    end

    variant type: :select do
      slot :default, class: "h-13 px-3.5"
    end

    variant type: :textarea do
      slot :default, class: "h-28 py-3 px-3.5"
    end
  end

  def initialize(type: :text, **html_attributes)
    @type = type
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(type: @type, class: @extra_class)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
