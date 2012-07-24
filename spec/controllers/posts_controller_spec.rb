require 'spec_helper'

describe PostsController do

  describe "GET 'index'" do
    before do
      get :index
    end
    it 'returns http success' do
      response.should be_success
    end
    it 'should populate @post' do
      assigns(:post).should be_kind_of(Post)
    end
  end

  describe "POST 'rate'" do
    let!(:tweet) { create :post, cumulative_rating: 10 }
    it 'adds rating to cumulative_rating' do
      expect {
        post :rate, id: tweet.to_param, rating: '2'
      }.to change{tweet.reload.cumulative_rating}.from(10).to(12)
    end
    it 'increments rating_count' do
      expect {
        post :rate, id: tweet.to_param, rating: '2'
      }.to change{tweet.reload.rating_count}.to(1)
    end
  end

end
