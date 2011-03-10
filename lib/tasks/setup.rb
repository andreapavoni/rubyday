require 'mysql'

namespace :db do
  
  desc "Create database"
  task :create do
    m = Mysql.init
    m.connect('localhost', 'root')
    if (m.list_dbs.find_index("rubyday").nil?)
      m.query("CREATE DATABASE rubyday")
    else
      puts 'rubyday DATABASE already there. Use rake db:purge to delete it'
    end
    m.close
  end
  
  desc "Drop database"
  task :drop do
    m = Mysql.init
    m.connect('localhost', 'root')
    if (! m.list_dbs.find_index("rubyday").nil?)
      m.query("DROP DATABASE rubyday")
    else
      puts 'rubyday DATABASE does not exists. Use rake db:create to delete it'
    end
    m.close
  end
  
  desc "Check database for existant"
  task :check do
    m = Mysql.init
    m.connect('localhost', 'root')
    if (! m.list_dbs.find_index("rubyday").nil?)
        puts 'rubyday db is in place'
    else
      puts 'rubyday db does not exists'
    end
    m.close
  end
end
