# Photoblog - [thatcameraguy.co.uk](http://thatcameraguy.co.uk)

I love to do photography and build web stuff so obviously I had to create a photoblog.

This blog app is somehow unique with the fact that it has no user web interface for creating
posts. Instead, everything gets generated from json data.

Why the hell would someone prefer that, you may ask.

Well, terminal is great and editing a json file with VIM is the best user interface for someone like me.

## Basic overview of functionality

Images are hosed on a Amazon S3 bucket.

Once manually uploaded, a `images:pull` rake task can be run to pull image meta from the AWS API.

References to new images get saved in the database.

`images:g` rake task generates json template for adding new posts from uploaded images.

`images:load` rake task uploads given json data as blog posts.

Simples.
