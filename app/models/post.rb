class Post

  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :cumulative_rating, type: Integer, default: 0
  field :rating_count, type: Integer, default: 0  # how often it was rated

  validates :body, presence: true

  def add_rating(rating)
    self.cumulative_rating += rating.to_i
    self.rating_count += 1
    self.save
  end

end
