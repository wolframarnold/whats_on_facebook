class PostsController < ApplicationController
  @@next_post = 'random'
  @@current_random=-1.0
  def index
    # Every time this action is called, it should return a new feed
    # possibly in chronological order or somehow randomized
    # We should keep track in the DB how often a feed was rated
    # and present feeds in order of lowest rated or something

    # This is just temporary. Eventually this will be database query of some sort.
    puts "in index, id: " + params[:id].to_s if params[:id].present?
    @@next_post = 'random' if @@next_post.nil?
    puts "next post is "+@@next_post + @@current_random.to_s

    if @@next_post=='random'
      rand_num=rand()
      puts rand_num
      @post=Post.where(:random.gte=>rand_num).first
      @post=Post.where(:random.lte=>rand_num).first if @post.nil?
    elsif @@next_post=='next'
      rand_num=@@current_random
      @post=Post.where(:random.gt=>rand_num).last
      @post=Post.where(:random.gte=>0.0).last if @post.nil?
      @@next_post='random'
    elsif @@next_post=='previous'
      rand_num=@@current_random
      @post=Post.where(:random.lt=>rand_num).first
      @post=Post.where(:random.lte=>1.0).first if @post.nil?
      @@next_post='random'
    end

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
    @post.add_rating(params[:type], params[:rating], cookies[:current_user_id], request.remote_ip)
    head :ok
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: {error: 'No such post'}, status: 404
  rescue => e
    Rails.logger.error e.message
    render json: {error: 'Server Error!'}, status: 500
  end

  def tag
    puts "========== a tag posted: "+ params[:tag] +" id: "+params[:id].to_s
    @post = Post.find(params[:id])
    @post.add_tag(params[:tag], cookies[:current_user_id], request.remote_ip)
    head :ok
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: {error: 'No such post'}, status: 404
  rescue => e
    Rails.logger.error e.message
    render json: {error: 'Server Error!'}, status: 500
  end

  def vote_peace
    vote('peace')
  end

  def vote_neutral
    vote('neutral')
  end

  def vote_violent
    vote('violent')
  end

  def vote(type)
    puts "========== a "+type+" vote for id: "+params[:id].to_s
    @post = Post.find(params[:id])
    @post.add_tag(type, cookies[:current_user_id], request.remote_ip)
    @@current_random=@post.random
    @@next_post = 'next'
    redirect_to posts_path
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: {error: 'No such post'}, status: 404
  rescue => e
    Rails.logger.error e.message
    render json: {error: 'Simple_tag Server Error!'}, status: 500
  end
end
