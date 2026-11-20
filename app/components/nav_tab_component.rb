# frozen_string_literal: true

class NavTabComponent < ViewComponent::Base
  include ClassVariants::Helper

  class_variants do
      base do
        slot :default, class: "inline-flex h-12 justify-center items-center gap-2 border-b-2 border-transparent hover:border-line-2 transition-all duration-200 ease-in-out cursor-pointer"
        slot :text, class: "font-mono text-t3 text-fg-2 font-medium"
      end

      variant state: :current do
        slot :default, class: "border-b-2 border-cyan hover:border-cyan"
        slot :text, class: "text-fg font-bold"
      end
  end

  def initialize(label:, badge: nil, current: false, href: nil, **html_attributes)
    @label = label
    @badge = badge
    @current = current
    @href = href
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(state: @current ? :current : nil, class: @extra_class)
  def text_classes = class_variants(:text, state: @current ? :current : nil)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
