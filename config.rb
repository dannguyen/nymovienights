require 'lib/movie'

#I18n.enforce_available_locales = true
set :markdown_engine, :kramdown

activate :directory_indexes


configure :development do
  activate :livereload
end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end


activate :s3_sync do |s3_sync|
#  s3_sync.aws_access_key_id  [in.s3_sync]        = 'AWS KEY ID'
#  s3_sync.aws_secret_access_key   [in.s3_sync]   = 'AWS SECRET KEY'
  s3_sync.region = 'us-east-1'
  s3_sync.bucket = 'somesight.com'
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
end



# Compass
###

# Change Compass configuration
compass_config do |config|
#   config.output_style = :compact
  config.http_path = "/"
  config.images_dir = "assets/images"
  config.javascripts_dir = "assets/javascripts"
end




ready do
  data.venues.each do |venue|
    proxy "/venues/#{venue.name.parameterize}", "/templates/venue.html", :locals => { :venue => venue}, :ignore => true
  end
end







# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

