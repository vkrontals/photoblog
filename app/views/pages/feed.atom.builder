atom_feed do |feed|
  feed.title Settings.site.title
  feed.updated @posts.last.publish_date if @posts.length > 0

  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.content, type: 'html')

      entry.author do |author|
        author.name("DHH")
      end
    end
  end
end
