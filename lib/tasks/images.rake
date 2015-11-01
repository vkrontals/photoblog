namespace :images do
  desc 'Get and save latest images from images host'
  task :pull, [:prefix] => :environment do |t, args|
    if args[:prefix].nil?
      prefix = Date.today.strftime('%Y/%m/')
    elsif args[:prefix] == 'all'
      prefix = ''
    else
      prefix = args[:prefix]
    end

    puts "pulling #{prefix.green}"
    image_list = Resources::ImagesHost.new(:new, prefix).images

    if image_list.count > 0

      puts "\nfound #{ image_list.count.to_s.green } #{ 'image'.pluralize(image_list.count)}"
      print "\nprocessing "

      new_images = []

      image_list.each do |image|
        begin
          img = Utils::ImagesBuilder.make_image(
            {
              'url' => image.url,
              'uploaded_time' => image.last_modified
            }, :new)
          if img
            img.save!
            new_images << img
            print '.'.green
          else
            print '.'.yellow
          end

        rescue
          print '.'.red
        end

      end
      puts "\n\n"
      if new_images.count > 0
        puts "added " + "#{ new_images.count } new #{ 'image'.pluralize(new_images.count)}".green + " to database"
        new_images.each { |x| puts " - #{ x.url }"}
      else
        puts 'All valid images already added to database!'
        puts 'No changes made'
      end
    else

      puts "\nNothing found".red
    end

  end

  task :hello, [:arg1] => :environment do |t, args|
    puts "Args were: #{args}"
  end

end
