module Authentication

  TIME_TOLERANCE = 10.minutes * 1000

  protected
  def extract_auth_header
    return if authorization_header.blank?
    authorization_header.split(';')
  end

  private
  def check_authorization
    if !authenticated?
      render json: { errors: ['invalid authentication']}, status: :unauthorized
    end
  end

  def authenticated?
    client_id, timestamp, hash = extract_auth_header
    api_key = ApiKey.find_by(client_id: client_id)
    if api_key && timestamp_ok?(timestamp) && hash
      token = api_key.access_token
      url = request.url
      return hash == calculate_hash(timestamp, url, token)
    end
  end

  def authorization_header
    request.headers["Authorization"]
  end

  def calculate_hash(timestamp, url, token)
    str = [timestamp, url, token].join(';')
    Digest::SHA256.hexdigest(str)
  end

  def timestamp_ok?(timestamp)
    timestamp = timestamp.to_i
    return false if timestamp == 0
    now = Time.now.utc.to_i
    oldest = now - TIME_TOLERANCE
    newest = now + TIME_TOLERANCE
    timestamp > oldest && timestamp < newest
  end

end
