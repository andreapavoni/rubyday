namespace :setup do
  desc "create db/rubyday.db sqlite file"
  task :database do
    db_dir = "#{Dir.pwd}/db"
    unless File.exists?("#{Dir.pwd}/db/rubyday.db") or Dir.exists?("#{Dir.pwd}/db")
      Dir.mkdir(db_dir)
      File.new("#{db_dir}/rubyday.db", "w")
    end
  end
end
