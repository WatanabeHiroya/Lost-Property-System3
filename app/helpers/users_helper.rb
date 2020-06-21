module UsersHelper
  
  def icon_url(user, options = { size: 80 })
    if user.email.present?
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      return "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    else
      return user.image_url
    end
  end
  
end
