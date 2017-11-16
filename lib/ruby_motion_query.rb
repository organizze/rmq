unless defined?(Motion::Project::App)
  raise "This must be required from within a RubyMotion Rakefile"
end

Motion::Project::App.setup do |app|
  app.detect_dependencies = false
  parent = File.join(File.dirname(__FILE__), '..')
  files = [File.join(parent, 'motion/ruby_motion_query/stylesheet.rb')]
  files << File.join(parent, 'motion/ruby_motion_query/validation_event.rb')
  files << File.join(parent, 'motion/ruby_motion_query/stylers/ui_view_styler.rb')
  files << File.join(parent, 'motion/ruby_motion_query/stylers/ui_control_styler.rb')
  files << File.join(parent, 'motion/ruby_motion_query/stylers/ui_text_field_styler.rb')
  files << Dir.glob(File.join(parent, "motion/**/*.rb"))
  files.flatten!.uniq!
  app.files.unshift files

  app.files_dependencies File.join(parent, "motion/ruby_motion_query/stylers/ui_scroll_view_styler.rb") => File.join(parent, "motion/ruby_motion_query/stylers/ui_view_styler.rb")

  app.files_dependencies File.join(parent, "motion/ruby_motion_query/stylers/ui_text_field_styler.rb") => File.join(parent, "motion/ruby_motion_query/stylers/protocols/ui_text_input_traits.rb")

  app.files_dependencies File.join(parent, "motion/ruby_motion_query/stylers/ui_table_view_styler.rb") => File.join(parent, "motion/ruby_motion_query/stylers/ui_scroll_view_styler.rb")

  app.development do
    app.info_plist["ProjectBuildTime"] = Time.now
    app.info_plist["ProjectRootPath"] = File.absolute_path(app.project_dir)
  end
end