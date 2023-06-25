class SessionsController < ApplicationController

  def omniauth_create
    auth_hash = request.env['omniauth.auth']
    @omniauth_authentication = OmniauthAuthentication.find_with_omniauth(auth_hash)
    uid = auth_hash[:uid]
    provider = auth_hash[:provider]
    email = auth_hash[:info][:email]
    first_name = auth_hash[:info][:first_name]
    last_name = auth_hash[:info][:last_name]
    avatar = auth_hash[:info][:image]
    url = auth_hash[:extra][:raw_info][:link]
    gender = auth_hash[:extra][:raw_info][:gender]

    if gender != "male" and gender != "female"
      gender = "other"
    end

    if (uid.present? and provider.present? and email.present? and first_name.present? and gender.present?)
      if my_signed_in?

        if @omniauth_authentication
          if @omniauth_authentication.user == my_current_user
            flash[:notice] = "Already linked that account!"
            redirect_to root_url
          else
            flash[:notice] = "An account is already linked with this profile"
            redirect_to root_path
          end
        else
          @omniauth_authentication = OmniauthAuthentication.new(uid: uid, provider: provider, url: url)
          @omniauth_authentication.user = my_current_user
          @omniauth_authentication.save
          flash[:notice] = "Successfully linked this account!"
          redirect_to root_url
        end


      else
        if @omniauth_authentication
          my_sign_in @omniauth_authentication.user
          redirect_to root_path, notice: "Signed in!!"
        else
          @user = User.where(email: email).first
          if !@user.nil?
            @omniauth_authentication = OmniauthAuthentication.new(uid: uid, provider: provider, url: url)
            @omniauth_authentication.user = @user
            if @omniauth_authentication.save
              my_sign_in @user
              redirect_to root_path, notice: "Signed in!!"
            else
              puts "Something went wrong errors"
              puts @omniauth_authentication.errors.messages
              redirect_to root_path, notice: "Something went wrong Please contact us"
            end
          else
            @user = User.new(first_name: first_name, last_name: last_name, unconfirmed_email: email, email: email, gender: gender)
            # @user.avatar_from_url(avatar) unless avatar.nil?
            @omniauth_authentication = @user.omniauth_authentications.build(uid: uid, provider: provider, url: url)
            if @user.save
              my_sign_in @user
              flash[:notice] = "Signed in!"
              redirect_to root_path
            else
              puts "Something went wrong errors"
              puts @user.errors.messages
              redirect_to root_path, notice: "Something went wrong Please contact us"
            end
          end
        end
      end
    # render :text => auth_hash.to_json or to_yaml or user.inspect
    else
      puts "Didnt receive data from your social networking account"
      redirect_to root_path, notice: "Didnt receive data from your social networking account"
    end
  end

  def omniauth_failure
    redirect_to root_url, notice: "Unable to link due to Technical error"
  end

  def session_status
    if my_signed_in?
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  def destroy
    my_sign_out
    redirect_to root_path
  end

end
