# frozen_string_literal: true

class BrandLockupComponentPreview < ViewComponent::Preview
  def default
    render(BrandLockupComponent.new(logo: "https://hackclub.com/assets/hackClubFlag.svg", badge: "LAN"))
  end

  def no_badge
    render(BrandLockupComponent.new(logo: "https://hackclub.com/assets/hackClubFlag.svg"))
  end

  def admin
    render(BrandLockupComponent.new(logo: "https://hackclub.com/assets/hackClubFlag.svg", badge: "LAN", role: "admin"))
  end
end
