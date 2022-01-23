require 'uri'

module Voucherify
  module Service
    class Validations
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def validate_voucher(code, context = {})
        @client.post("/vouchers/#{ERB::Util.url_encode(code)}/validate", context.to_json)
      end

      def validate_bulk_vouchers(params)
        @client.post('/validations', params.to_json)
      end

      def validate(code, context = {})
        if code.is_a? Hash
          context = code
          return @client.promotions.validate(context)
        end
        @client.validations.validate_voucher(code, context)
      end

    end
  end
end
