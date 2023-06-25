class VotesController < ApplicationController
 include SanitizableParams
 before_action :redirect_for_guest_user 


#@vote_saved indicates the fate of results, if successful @new_vote_count will provide the updated votes count
 def create
   @votable=find_votable
   @vote_saved = false
   if !@votable.nil?
    @vote = @votable.votes.new
    @vote.user=my_current_user
    voteCount = @votable.votes_count || 0
    if @vote.save
     @vote_saved = true
     @votable.update_field_count("votes_count",true,1)
     my_current_user.update_field_count("votes_count",true,1)
     voteCount=voteCount+1
     @new_vote_count = voteCount
    end   
   end 
  
   respond_to do |format|
    format.js
   end
 end

#destroy vote , unvote
 def destroy
  @votable=find_votable
  @vote=Vote.find(params[:id])
  @vote_deleted = false  
  if !@votable.nil? && !@vote.nil? && (my_current_user.id==@vote.votable_id)
   @vote.destroy
   voteCount=@votable.votes_count || 0
   if @vote.destroyed?
    @vote_deleted = true
    @votable.update_field_count("votes_count",false,1)
    my_current_user.update_field_count("votes_count",false,1)
    voteCount=voteCount-1
   end
   @new_vote_count = voteCount
  end
  respond_to do |format|
   format.js
  end

 end



 private
#since its polymorphic , abstracts the param request by fetching X from X_id , X is video now later others. 
#a drawback, the params must have only one X_id 
 def find_votable
   params.each do |name, value|
     if name =~ /(.+)_id$/
       return $1.classify.constantize.find(value)
     end
   end
   nil
 end
end
