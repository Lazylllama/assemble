# frozen_string_literal: true

class AdminTopComponent < ViewComponent::Base
  include ClassVariants::Helper

  class_variants do
    base do
      slot :default, class: "flex justify-between items-center h-16 w-full px-8 border-b border-line bg-bg"
      slot :email, class: "font-mono text-t2 text-fg-2"
    end
  end

  def initialize(email:, logo: nil, badge: nil, role: nil, **html_attributes)
    @email = email
    @logo = logo
    @badge = badge
    @role = role
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes = class_variants(class: @extra_class)
  def email_classes = class_variants(:email)

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
