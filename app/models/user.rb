class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    user = User.where(uid: auth.uid).first_or_initialize do |user|
      user.name             = auth.info.name
      user.email            = auth.info.email
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
    user
  end

  def facebook
  @facebook ||= Koala::Facebook::API.new(oauth_token)
end
end
