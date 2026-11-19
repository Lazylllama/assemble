class UiTestersController < ApplicationController
  # Same sections, in the same order, as the "LBS UI Kit" page in Figma.
  # A component that isn't listed here still shows up, under "Övrigt".
  FIGMA_SECTIONS = {
    "Actions + status" => %w[Button Status Badge Kbd],
    "Forms" => %w[Field Checkbox Radio CheckRow TeamOption Disclosure],
    "Brand + shell" => %w[Lockup TopBar AdminTop AdminNav Tab],
    "Feedback" => %w[Pane Flash Dialog],
    "Data" => %w[TableHeader TableRow KvRow FactRow Step],
    "Lists + navigation" => %w[FilterItem FilterBar Search Crumbs BackLink SectionHead EmptyState Seats MemberRow TeamHead],
    "Door + ticket" => %w[DoorRow DoorStatusBar ScanView Ticket AlertPane QrCode]
  }.freeze

  # Lets previews that use render_with_template find their .html.erb files.
  before_action { prepend_view_path ViewComponent::Base.previews.paths }

  def index
    components = Dir[Rails.root.join("app/components/**/*_component.rb")].map do |path|
      path.delete_prefix("#{Rails.root.join("app/components")}/").delete_suffix("_component.rb").camelize
    end

    @sections = FIGMA_SECTIONS.transform_values { |names| names & components }
    @sections["Övrigt"] = components - FIGMA_SECTIONS.values.flatten
    @sections.reject! { |_section, names| names.empty? }

    @previews = ViewComponent::Preview.all.index_by { |preview| preview.name.delete_suffix("ComponentPreview") }
  end
end
