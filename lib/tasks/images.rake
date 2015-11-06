require 'fileutils'

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

  desc 'Get stats of all the things'
  task stats: :environment do
    live_posts = Post.where(['publish_date <= ?', DateTime.now]).count
    future_posts = Post.where(['publish_date > ?', DateTime.now]).count
    image_count = Image.where('post_id IS NULL').count

    puts '╔════════════ stats ═════════════╗'.green
    puts '║%3.0f - images without posts      ║' % image_count
    puts '║%3.0f - live posts                ║' % live_posts
    puts '║%3.0f - future posts              ║' % future_posts
    puts '╚════════════════════════════════╝'.green
  end

  desc 'Generate json posts from images'
  task g: :environment do
    image_without_posts = Image.where('post_id IS NULL')
    latest_post_date = Post.order(publish_date: :desc)

    if latest_post_date.blank?
      latest_post_date = DateTime.now
    else
      latest_post_date = latest_post_date
                           .first
                           .publish_date
                           .to_datetime
                           .change(hour: 9, minute: 0)
    end


    json_array = []
    errors = []

    image_without_posts.each do |image|
      begin
        post = Utils::ImageToPost.make(image)
        post.publish_date = latest_post_date

        latest_post_date += 1.day

        json_array << post
      rescue Errors::Image::InvalidUrlFormat
        errors << "Invalid url: #{image}".red

      rescue
        errors << "Some error: #{$!}: #{image}".red
      end

    end

    FileUtils::mkdir_p('tmp/posts_json')

    today = Date.today()

    File.open("tmp/posts_json/#{today.strftime('%Y%m%d')}_posts.json", 'w') do |file|
      file.write('[' + json_array.map(&:to_json).join(',') + ']')
    end

    # puts '[' + json_array.map(&:to_json).join(',') + ']'
    puts errors if errors.any?
  end


  desc 'Upload json posts'
  task load: :environment do |t, args|
    latest_json_path = Dir.glob(File.join('tmp/posts_json/', '*.*')).max { |a,b| File.ctime(a) <=> File.ctime(b) }

    json = File.read(latest_json_path)
    posts_array = JSON.parse json

    count = 0
    posts_array.each do |post|
      print 'Processing: ' + post["title"]
      begin
        Utils::PostsBuilder.make_post(post).save!

        print " success\n".green
        count += 1
      rescue
        puts " #{$!}".red
      end

    end

    puts "created #{count} posts".green

  end

end
