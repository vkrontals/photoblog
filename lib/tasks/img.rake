namespace :img do
  desc "list images"
  task list: :environment do
    puts 'Starting to get images..'
    test = Resources::ImagesHost.new.images

    puts "got #{ test.count } #{ 'image'.pluralize(test.count)}:"
    test.each { |x| puts " - #{x.url}" }
  end

end
