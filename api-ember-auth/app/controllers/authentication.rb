module Authentication

  TIME_TOLERANCE = 6000000

  def included(base)
    base.send(:before_filter, :authenticated?)
  end

  private
  def authenticated?
    client_id, timestamp, hash = extract_auth_header
    api_key = ApiKey.find_by(client_id: client_id)
    if api_key && timestamp && hash
      token = api_key.access_token
      url = request.url
      return hash == calculate_hash(timestamp, url, token)
    end
    false
  end

  def authorization_header
    request.headers["Authorization"]
  end

  def extract_auth_header
    return if authorization_header.blank?
    authorization_header.split(';')
  end

  def calculate_hash(timestamp, url, token)
    str = [timestamp, url, token].join(';')
    Digest::SHA256.hexdigest(str)
  end

  def timestamp_ok?(timestamp)
    now = Time.now.utc.to_i
    oldest = now - TIME_TOLERANCE
    newest = now + TIME_TOLERANCE
    timestamp > oldest && timestamp < newest
  end

end
