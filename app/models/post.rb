class Post

  include Mongoid::Document
  include Mongoid::Timestamps

  #field :pid,  type: Integer
  field :random, type: Float
  field :body, type: String
  field :votes, type: Array, default: []
  field :cumulative_rating, type: Integer, default: 0
  field :rating_count, type: Integer, default: 0  # how often it was rated

  validates :body, presence: true

  def add_rating(rating, current_user_id)
    #puts "adding vote for "+body+" Rating: "+ rating.to_s+" By: "+current_user_id.to_s
    self.cumulative_rating += rating.to_i
    #self.votes=[] if self.votes.nil?
    self.votes<<{current_user_id=>rating}
    self.rating_count += 1
    self.save
  end

  def self.add_post(body)
    p=self.new
    p.body=body
    p.random = rand
    p.save
  end
end
