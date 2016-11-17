class PostsController < ApplicationController
	before_action :require_login, only: [:new, :create]

	def index
		@posts = Post.paginate(page: params[:page], per_page: 20)
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
			if @post.save
				flash.now[:success] = 'Post created'
				redirect_to root_path
			else
				flash.now[:danger] = 'Post failure'
				render 'new'
			end
	end

	private

		def post_params
			params.require(:post).permit(:title, :content)
		end

		def require_login
			unless logged_in?
				flash[:danger] = 'User must be logged in'
				redirect_to login_path
			end
		end
end
