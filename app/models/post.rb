class Post

  include Mongoid::Document
  include Mongoid::Timestamps

  #field :pid,  type: Integer
  #field :random, type: Float
  field :search_keyword, type: String, default: ""
  field :body, type: String
  field :votes, type: Array, default: []
  field :cumulative_rating, type: Integer, default: 0
  field :rating_count, type: Integer, default: 0  # how often it was rated

  validates :body, presence: true

  def add_rating(rating, current_user_id, ip)
    #puts "adding vote for "+body+" Rating: "+ rating.to_s+" By: "+current_user_id.to_s
    #self.cumulative_rating += rating.to_i
    #self.votes<<{current_user_id=>[Time.now,ip,rating]}
    self.votes<<{:voter_id=>current_user_id, :time=>Time.now, :ip=>ip, :rating=>rating}
    #self.rating_count += 1
    self.save
  end

  def add_tag(tag, current_user_id, ip)
    self.votes<<{:voter_id=>current_user_id, :time=>Time.now, :ip=>ip, :tag=>tag}
    self.save
  end



  def self.add_post(body, search_keyword)
    p=self.new
    p.body=body
    p.search_keyword = search_keyword
    p.random = rand
    p.save
    p
  end

  def import_from_csv(fname)
    csv_text = File.read('../../python/fbcorpus.txt')
    rows=csv_text.encode('UTF-8', 'UTF-8', :invalid => :replace).split("\r")
    rows.each do |row|
      a_post = row.split("\t")
      p=self.add_post(a_post[3], a_post[0]) #body, search_keyword

    end
  end
end
