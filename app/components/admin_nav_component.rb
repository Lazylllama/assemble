# frozen_string_literal: true

class AdminNavComponent < ViewComponent::Base
  include ClassVariants::Helper

  class_variants do
    base do
      slot :default, class: "flex flex-row gap-8 px-8 bg-bg border-b border-line-2"
    end
  end

  def initialize(tabs:, **html_attributes)
    @tabs = tabs
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(class: @extra_class)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
