module Devise
  module Strategies
    class CookiesJsonWebToken < Base
      def valid?
        cookies[:jwt].present?
      end

      def authenticate!
        decoded_token = ::DecodeJwtToken.call(token: cookies[:jwt]).body
        return fail! if decoded_token.blank?

        user = User.find_by(id: decoded_token[:user_id])
        user ? success!(user) : fail!
      end
    end
  end
end
