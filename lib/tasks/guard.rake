namespace :db do
  namespace :guard do
    task :prepare => [:environment] do
      original_environment = Rails.env
      Rails.env = 'guard'
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:schema:load'].invoke
      Rails.env = original_environment
    end
  end
end
