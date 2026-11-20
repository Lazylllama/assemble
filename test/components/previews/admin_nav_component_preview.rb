# frozen_string_literal: true

class AdminNavComponentPreview < ViewComponent::Preview
    TABS = [
    { label: "Not Current" },
    { label: "Current", current: true },
    { label: "Badge Not Curent", badge: "1" },
    { label: "Badge Current", current: true, badge: "1" }
  ].freeze

  def default
    render(AdminNavComponent.new(tabs: TABS))
  end
end
