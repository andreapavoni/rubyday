namespace :jammit do
  desc "Jam all assets!"
  task :compress => :environment do
    puts "Packaging all assets.."
    Jammit.package!
    puts "Done!"
  end
end