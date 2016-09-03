json.id @user.id
json.username @user.username
json.avatar_image_tag avatar_for(@user, size: 50)
json.urlPath user_path(@user)
json.hideButton user_signed_in? && current_user?(@user)
