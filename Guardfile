# A sample Guardfile
# More info at https://github.com/guard/guard#readme

notification :file, :path => '.guard_result'

ignore! /tmp/, /public/

guard :bundler do
  watch('Gemfile')
end

guard 'passenger' do
  watch(/^lib\/.*\.rb$/)
  watch(/^config\/.*\.rb$/)
  watch('Gemfile.lock')
  watch(/^lib\/grammars\/.*\.treetop$/)
end

guard :shell do
  watch('db/schema.rb') { `rake db:guard:prepare` }
end

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'guard' }, :rspec_port => 8888, :rspec => true, :aggressive_kill => false, :wait => 60 do
  watch('config/application.rb')
  watch('config/routes.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.*\.rb$})
  watch(%r{^config/initializers/.*\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
  watch(%r{^app/serializers/(.+)\.rb})
  watch(/^lib\/grammars\/.*\.treetop$/)
end

guard 'rspec', :cmd => 'rspec --drb --drb-port 8888', :env => {'RAILS_ENV' => 'guard'}, :all_on_start => false, :all_after_pass => false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/features/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  # watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }

end

guard :jasmine, :all_on_start => false do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$}) { 'spec/javascripts' }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{spec/javascripts/fixtures/.+$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)(?:\.\w+)*$}) { |m| "spec/javascripts/#{ m[1] }_spec.#{ m[2] }" }
  watch(%r{app/assets/javascripts/templates/(.+?)\.(jst\.eco)(?:\.\w+)*$}) { |m| "spec/javascripts/views/#{ m[1] }_view_spec.js.coffee" }
end
