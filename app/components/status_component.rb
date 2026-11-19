class StatusComponent < ViewComponent::Base
  include ClassVariants::Helper

  LABELS = {
    none: "Inte skickad",
    sent: "Väntar på underskrift",
    opened: "Öppnad",
    ok: "Underskriven",
    na: "Behövs inte (18+)",
    stop: "Avböjd",
    in: "Incheckad"
  }

  KINDS = LABELS.keys.freeze

  class_variants(
    base: "inline-flex items-center gap-2 font-mono text-t3 font-medium",
    variants: {
      kind: {
        none: "text-fg-2",
        sent: "text-yellow",
        opened: "text-yellow",
        ok: "text-green",
        na: "text-fg-2",
        stop: "text-magenta-t",
        in: "text-fg-2"
      }
    },
    defaults: { kind: :none }
  )

  def initialize(kind: :none, label: nil, **html_attributes)
    @kind = kind
    @label = label || LABELS.fetch(kind, "Okänd status")
    @extra_class = html_attributes.delete(:class)
    @html_attributes = html_attributes
  end

  private

  def classes
    class_variants(kind: @kind, class: @extra_class)
  end

  def html_attributes
    @html_attributes.merge(class: classes)
  end
end
