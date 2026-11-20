# frozen_string_literal: true

class BrandLockupComponent < ViewComponent::Base
  include ClassVariants::Helper

  class_variants do
    base do
      slot :default, class: "inline-flex items-center gap-2.5 max-h-11 overflow-hidden contain-content"
      slot :logo, class: "max-h-11 py-2"
      slot :badge, class: "bg-cyan font-mono font-extrabold text-cyan-d text-t4 px-1"
      slot :role, class: "px-1 border-2 border-dashed rounded-xs border-orange font-mono text-t1"
    end
  end

  def initialize(logo: nil, badge: nil, role: nil, **html_attributes)
    @logo = logo
    @badge = badge
    @role = role
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(class: @extra_class)
  def logo_classes = class_variants(:logo)
  def badge_classes = class_variants(:badge)
  def role_classes = class_variants(:role)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
