# frozen_string_literal: true

class PaneComponent < ViewComponent::Base
  include ClassVariants::Helper

  GLYPH = {
    yellow: :sent,
    magenta: :stop
  }.freeze

  class_variants do
    base do
      slot :default, class: "relative border p-4 pt-6 rounded-xs"
      slot :title, class: "absolute top-0 left-2.5 -translate-y-1/2 flex items-center gap-2 px-1 font-mono font-bold text-t3"
      slot :body, class: "text-t3"
    end

    variant tone: :yellow do
      slot :default, class: "border-yellow-e bg-yellow-d"
      slot :title, class: "text-yellow bg-linear-to-b from-bg from-50% to-yellow-d to-50%"
      slot :body, class: "text-fg"
    end

    variant tone: :magenta do
      slot :default, class: "border-magenta-e bg-magenta-d"
      slot :title, class: "text-magenta-t bg-linear-to-b from-bg from-50% to-magenta-d to-50%"
      slot :body, class: "text-fg"
    end
  end

  def initialize(tone: :yellow, title:, **html_attributes)
    @tone = tone
    @title = title
    @glyph = GLYPH.fetch(tone, "none")
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(tone: @tone, class: @extra_class)
  def title_classes = class_variants(:title, tone: @tone)
  def body_classes = class_variants(:body, tone: @tone)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
