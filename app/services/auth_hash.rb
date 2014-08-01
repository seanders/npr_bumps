class AuthHash

  attr_reader :uid, :type, :email, :name

  def initialize(auth_data)
    user_info = auth_data['info']
    @uid = auth_data['uid']
    @type = auth_data['type']
    @name = user_info['name']
    @email = user_info['email']
    @image_url = user_info['image']
    @token = user_info['credentials']['token']
    @refresh_token = user_info['credentials']['refresh_token']
    @expires_at = user_info['credentials']['expires_at']
  end

  def linked_account_attributes
    {
      uid: @uid,
      type: @type,
      name: @name,
      email: @email,
      image_url: @image_url,
      token: @token,
      refresh_token: @refresh_token,
      expires_at: @expires_at
    }
  end
end
