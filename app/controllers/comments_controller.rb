class CommentsController < ApplicationController
 include SanitizableParams
 before_action :redirect_for_guest_user

#update/edit comments, use @comment_updated in view to check whether the update was successful
 def update
  @comment = Comment.find(params[:id])
  @comment_updated=false
  if !@comment.nil? && (my_current_user.id==@comment.commentable_id) && @comment.update_attributes(content: params[:comment][:description])
   @comment_updated=true
  end
  respond_to do |format|
   format.js
  end
 end

#delete comments, @comment_deleted indicates whether the delete was successful, if so @new_comment_count gives the new count
#make sure the commentable has update_comment_count imeplemented
 def destroy
  @commentable = find_commentable
  @comment=Comment.find(params[:id])
  @comment_deleted = false
  
  if !@commentable.nil? && !@comment.nil? && (my_current_user==@comment.user)
   @comment.destroy
   commentCount=@commentable.comments_count || 0
   if @comment.destroyed?
    @comment_deleted = true
    @commentable.update_field_count("comments_count",false,1)
    my_current_user.update_field_count("comments_count",false,1)
    commentCount=commentCount-1
   end
   @new_comment_count = commentCount
  end
  respond_to do |format|
   format.js
  end

 end

#add/create comment,  @comment_saved tells whether the addition was succesful, if so use @new_comment_count for new count
 def create
   @commentable = find_commentable
   @comment_saved = false
   if !@commentable.nil? && !params[:comment].nil?
    @comment = @commentable.comments.new
    @comment.content = params[:comment][:description]
    @comment.user = my_current_user
    commentCount=@commentable.comments_count || 0
    if @comment.save
     @comment_saved = true
     @commentable.update_field_count("comments_count",true,1)
     my_current_user.update_field_count("comments_count",true,1)
     commentCount=commentCount+1
    end
    @new_comment_count = commentCount
   end
   respond_to do |format|
    format.js
   end
 end


 private
#since its polymorphic , abstracts the param request by fetching X from X_id , X is video now later others. 
#a drawback, the params must have only one X_id 
 def find_commentable
   params.each do |name, value|
     if name =~ /(.+)_id$/
       return $1.classify.constantize.find(value)
     end
   end
   nil
 end
end
