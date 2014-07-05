desc "Pulls quotes for each user in the background" 
task :pull_quotes_from_goodreads => :environment do
  PullQuotesFromGoodreads.new.perform
end
