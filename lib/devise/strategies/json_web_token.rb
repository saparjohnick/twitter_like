module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        request.headers['HTTP_AUTHORIZATION'].present?
      end

      def authenticate!
        token = request.headers['HTTP_AUTHORIZATION'].split.last
        decoded_token = ::DecodeJwtToken.call(token: token).body
        return fail! if decoded_token.blank?

        user = User.find_by(id: decoded_token[:user_id])
        user ? success!(user) : fail!
      end
    end
  end
end
