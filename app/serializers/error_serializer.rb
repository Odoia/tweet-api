module ErrorSerializer

  def self.call(errors:, status:)
    if errors.nil?
      return bad_request if status == 400
      return not_found if status == 404
    end

    return serialize(errors, status)
  end

  private

  def self.bad_request
    {status: 400, error: 'Bad Request'}
  end

  def self.not_found
    {status: 404, error: 'Not Found'}
  end

  def self.serialize(errors, status)

    json = {}
    new_hash = errors.to_hash.map do |k, v|
      v.map do |msg|
        { id: k, title: msg, status: status }
      end
    end.flatten
    json[:errors] = new_hash
    json
  end
end
