AuthHash = Struct.new(:uid, :type, :email, :name, :image_url, :token, :refresh_token, :expires_at) do

  def initialize(auth_data)
    # this is meant to allow proper assigning of attributes regardless of the order of the arguments
    super(*build_attributes_array(auth_data))
  end

  def build_attributes_array(auth_data)
    user_info = auth_data['info']
    [
      auth_data['uid'],
      auth_data['provider'],
      user_info['name'],
      user_info['email'],
      user_info['image'],
      auth_data['credentials']['token'],
      auth_data['credentials']['refresh_token'],
      auth_data['credentials']['expires_at']
    ]
  end
end
