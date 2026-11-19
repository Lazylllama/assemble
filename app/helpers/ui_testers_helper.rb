module UiTestersHelper
  # Preview examples in the order they're written in the preview file.
  def preview_examples(preview)
    preview.public_instance_methods(false)
      .sort_by { |name| preview.instance_method(name).source_location.last }
      .map(&:to_s)
  end

  # Renders one preview example the same way /rails/view_components does.
  # A broken component shows its error inline instead of killing the page.
  def render_preview_example(preview, example)
    args = preview.render_args(example)

    if args[:component]
      render(args[:component], args[:args], &args[:block])
    else
      render(template: args[:template], locals: args[:locals] || {})
    end
  rescue StandardError => error
    tag.p("#{error.class}: #{error.message}", class: "font-mono text-t2 text-magenta-t")
  end
end
