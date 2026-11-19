ClassVariants.configure do |config|
  merger = TailwindMerge::Merger.new(config: {
    theme: { "text" => %w[t1 t2 t3 t4 t5 t6 t7] }
  })

  config.process_classes_with { |classes| merger.merge(classes) }
end
