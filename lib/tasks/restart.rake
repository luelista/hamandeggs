
desc "Restart app"
task :restart => :environment do
    `touch tmp/restart.txt`
end
desc "Display log file in following mode"
task :logcat => :environment do
    puts "Displaying log file..."
    system "tail -f log/development.log"
end