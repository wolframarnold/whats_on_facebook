class PostsController < ApplicationController
  def index
    # Every time this action is called, it should return a new feed
    # possibly in chronological order or somehow randomized
    # We should keep track in the DB how often a feed was rated
    # and present feeds in order of lowest rated or something

    # This is just temporary. Eventually this will be database query of some sort.
    rand_num=rand()
    @post=Post.where(:random.gte=>rand_num).first
    @post=Post.where(:random.lte=>rand_num).first if @post.nil?

    #@post = Post.find_or_create_by(body: "I think the idea of crowdsourcing posts rating for training a natural language predictor is brilliant.")

    # add current_user_id to cookie to track individual voters
    cookies[:current_user_id] = Digest::SHA1.hexdigest("---#{Time.now.to_s}---#{request.remote_ip}---")[8,16]  if cookies[:current_user_id].nil?
    #session[:current_user_id]=rand(1000000000) if session[:current_user_id].nil?
    puts "current user: "+cookies[:current_user_id].to_s
  end

  def rate
    #puts "rated by: "+session[:current_user_id].to_s
    @post = Post.find(params[:id])
    puts "param: "+ params[:type].to_s+" id: "+cookies[:current_user_id].to_s+" ip: "+request.remote_ip.to_s
    #@post.add_rating(params[:violence_rating], cookies[:current_user_id], request.remote_ip)
    head :ok
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: {error: 'No such post'}, status: 404
  rescue => e
    Rails.logger.error e.message
    render json: {error: 'Server Error!'}, status: 500
  end

  def tag
    puts "========== a tag posted: "+ params[:tag] +" id: "+params[:id].to_s
    head :ok
  end
end
