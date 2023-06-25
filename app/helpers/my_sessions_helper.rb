module MySessionsHelper

  def my_sign_in(user)

    remember_token = User.new_remember_token
    cookies.permanent.signed[:remember_token] = remember_token
    user.update_attribute(:remember_token, remember_token)
    self.my_current_user = user
  end

  def my_current_user=(user)
    @my_current_user = user
  end

  def my_current_user
    @my_current_user ||= User.find_by(remember_token: cookies.signed[:remember_token]) if cookies[:remember_token]
  end
#FIXME presence of session variable cant indicate authentic users in some cases, use redirect_for_guest_user
#  def my_signed_in?
#    !my_current_user.nil?
#  end

#use id instead of object, some cases only id might be available
  def my_current_user?(user_id)
     check_auth_user? && my_current_user.id==user_id
  end

  def my_sign_out
    self.my_current_user = nil
    cookies.delete(:remember_token)
  end


#all before_filter must have this, where content mutation/creation is intended
  def redirect_for_guest_user
   if check_auth_user?
    flash[:error] = "Please Login, to continue"
    return false
   end
  end

  def check_auth_user?
   if my_current_user.nil? || my_current_user.remember_token.nil? || my_current_user.remember_token!=cookies.signed[:remember_token]
    return false
   else
    return true
   end
  end
end
