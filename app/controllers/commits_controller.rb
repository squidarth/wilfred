class CommitsController < ApplicationController
  # GET /commits
  # GET /commits.json
  PAST_COMMIT_COUNT = 25 
  
  before_filter :get_commit, only: [:verify, :fail]
  def index
    @user = current_user 

    prepare_commits
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commits }
    end
  end

  def verify
    @commit.update_attributes(state: "verified")
    prepare_commits

    if ENV["HIPCHAT_TOKEN"].present? && ENV["HIPCHAT_ROOM"] && @unchecked_commits.empty? && @failed_commits.empty? # all commits are good
      client = HipChat::Client.new(ENV["HIPCHAT_TOKEN"])
      client[ENV["HIPCHAT_ROOM"]].send('Wilfred', 'All commits have been verified!', color: ENV["HIPCHAT_COLOR"] || "green")
    end

    render json: {
      success: true,
      html: render_to_string(partial: "commit_content",
                             locals: {
                                past_commits: @past_commits,
                                failed_commits: @failed_commits,
                                unchecked_commits: @unchecked_commits,
                              }
      )}
  end
  
  def fail
    @commit.update_attributes(state: "failed")
    prepare_commits
    render json: {
    success: true,
    html: render_to_string(partial: "commit_content",
                           locals: {
                              past_commits: @past_commits,
                              failed_commits: @failed_commits,
                              unchecked_commits: @unchecked_commits,
                            }
    )}
  end 
  
  
  
  # GET /commits/1
  # GET /commits/1.json
  def show
    @commit = Commit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commit }
    end
  end

  # GET /commits/new
  # GET /commits/new.json
  def new
    @commit = Commit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commit }
    end
  end

  # GET /commits/1/edit
  def edit
    @commit = Commit.find(params[:id])
  end

  # POST /commits
  # POST /commits.json
  def create
    @commit = Commit.new(params[:commit])

    respond_to do |format|
      if @commit.save
        format.html { redirect_to @commit, notice: 'Commit was successfully created.' }
        format.json { render json: @commit, status: :created, location: @commit }
      else
        format.html { render action: "new" }
        format.json { render json: @commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commits/1
  # PUT /commits/1.json
  def update
    @commit = Commit.find(params[:id])

    respond_to do |format|
      if @commit.update_attributes(params[:commit])
        format.html { redirect_to @commit, notice: 'Commit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commits/1
  # DELETE /commits/1.json
  def destroy
    @commit = Commit.find(params[:id])
    @commit.destroy

    respond_to do |format|
      format.html { redirect_to commits_url }
      format.json { head :no_content }
    end
  end

  private

  def get_commit
    @commit = Commit.find(params[:id])
  end

  def prepare_commits
    @past_commits = Commit.verified.order("created_at DESC").limit(PAST_COMMIT_COUNT).all
    @failed_commits = Commit.failed
    @unchecked_commits = Commit.unchecked
  end
end
