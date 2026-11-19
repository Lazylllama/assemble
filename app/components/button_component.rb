class ButtonComponent < ViewComponent::Base
    include ClassVariants::Helper

    class_variants(
        base: "border rounded-xs gap-2 font-mono font-bold transition-all duration-100 ease-in-out text-t3 disabled:opacity-50",
        variants: {
            style: {
                primary: "bg-cyan not-disabled:hover:bg-cyan-hover text-cyan-d border-cyan",
                secondary: "text-cyan not-disabled:hover:bg-cyan-d border-cyan px-4",
                ghost: "border-edge not-disabled:hover:border-fg-2 not-disabled:hover:bg-bg-2",
                danger: "border-magenta-e text-magenta-t not-disabled:hover:bg-magenta-d",
                text: "border-none underline underline-offset-2 text-fg-2 hover:text-fg px-1 font-medium"
            },
            size: {
                default: "h-11 px-4",
                block: "h-14"
            }
        },
        compound_variants: [
            {
                style: :text,
                size: :default,
                class: "h-auto! p-0!"
            }
        ],
        defaults: {
            style: :primary,
            size: :default
        }
    )

    def initialize(style: :primary, size: :default, href: nil, disabled: false, **html_attributes)
        @style = style
        @size = size
        @href = href
        @disabled = disabled
        @extra_class = html_attributes.delete(:class)
        @html_attributes = html_attributes
    end

    private

    def classes
        class_variants(style: @style, size: @size, class: @extra_class)
    end

    def html_attributes
      attributes = @html_attributes.merge(class: classes)

      if @href.present?
        attributes[:href] = @href
        attributes.merge!(aria: { disabled: "true" }, tabindex: "-1") if @disabled
      else
        attributes[:disabled] = true if @disabled
      end

      attributes
    end
end
