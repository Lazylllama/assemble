# frozen_string_literal: true

class AdminTopComponentPreview < ViewComponent::Preview
  def default
    render(AdminTopComponent.new(email: "name@example.com", logo: "https://hackclub.com/assets/hackClubFlag.svg", badge: "LAN", role: "admin"))
  end
end
