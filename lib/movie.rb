class Movie

  attr_reader :time, :title, :summary, :image_url, :external_url
  def initialize(hsh)
    @title = hsh.title
    @time = hsh.time
    @image_url = "//placekitten.com/400/300"
    @summary = "abc Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil, temporibus, consequuntur, aut distinctio sequi dolores corrupti et sunt  eveniet harum ut.".split(' ').shuffle[0..20].join(' ')
    @external_url = "//imdb.com"
  end

end
