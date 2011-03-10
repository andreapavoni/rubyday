require 'dm-migrations'

namespace :setup do
  desc "Perform automigration"
  task :migrate do
    DataMapper.auto_migrate!
  end
end
