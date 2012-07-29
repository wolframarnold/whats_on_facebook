class Post

  include Mongoid::Document
  include Mongoid::Timestamps

  #field :pid,  type: Integer
  field :random, type: Float
  field :search_keyword, type: String, default: ""
  field :body, type: String
  field :votes, type: Array, default: []
  field :tags, type: Array, default: []
  field :cumulative_rating, type: Integer, default: 0
  field :rating_count, type: Integer, default: 0  # how often it was rated

  index({random: 1})
  validates :body, presence: true

  def add_rating(rating_type, rating, current_user_id, ip)
    self.votes<<{:voter_id=>current_user_id, :time=>Time.now, :ip=>ip, :type=>rating_type, :rating=>rating}
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

  def self.clear_all_posts
    Post.each {|p| p.delete}
  end

  def self.clear_all_voting
    Post.each do |p|
      p.votes=[]
      p.save
    end
  end



  def self.import_from_csv
    csv_text = File.read('../../python/fbcorpus.txt')
    rows=csv_text.encode('UTF-8', 'UTF-8', :invalid => :replace).split("\r")

    tags=rows.collect do |row|
      a_post=row.split("\t")
      a_post[2] if a_post[2].present?
    end.compact!


    rows[0..5].map do |row|
      a_post = row.split("\t")
      if a_post[3].length > 25 && a_post[3].length<500
        p=Post.add_post(a_post[3], a_post[0]) #body, search_keyword
        if a_post[1].present?   #Weidong has given it a sentiment rating already pos 1, neg 5
          rating = (a_post[1]=="pos") ? 1 : 5
          p.add_rating("sentiment", rating, 1, "127.0.0.1")
        end
        if a_post[2].present? #Weidong has given it a tag
          tag=a_post[2].downcase
          if tag=='hate' || tag=='violence' || tag=='anger'
            p.add_rating("violence", rating, 5, "127.0.0.1")
          else
            p.add_tag(tag, 1, "127.0.0.1")
          end
        end
      end
    end
  end
end
