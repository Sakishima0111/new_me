class GroupPostsController < ApplicationController

  def create

    @group = Group.find(params[:group_post][:group_id])
    @group_post = @group.group_posts.new(group_post_params)
    @group_post.user = current_user

    if @group_post.save
      redirect_to group_path(@group_post.group)
    else
      @groupposts = GroupPost.where(group_id: @group.id).all.order(created_at: :asc)
      render template: "groups/show"
    end
  end

  private
    def group_post_params
      params.require(:group_post).permit(:content)
    end

end
