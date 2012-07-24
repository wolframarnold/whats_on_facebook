class PostsController < ApplicationController
  def index
    # Every time this action is called, it should return a new feed
    # possibly in chronological order or somehow randomized
    # We should keep track in the DB how often a feed was rated
    # and present feeds in order of lowest rated or something

    # This is just temporary. Eventually this will be database query of some sort.
    @post = Post.find_or_create_by(body: "I think the idea of crowdsourcing posts rating for training a natural language predictor is brilliant.")
  end

  def rate
    @post = Post.find(params[:id])
    @post.add_rating(params[:rating])
    head :ok
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: {error: 'No such post'}, status: 404
  rescue => e
    Rails.logger.error e.message
    render json: {error: 'Server Error!'}, status: 500
  end
end
