require 'minitest'
require "minitest/unit"
require "minitest/autorun"
require 'minitest/power_assert'
require 'rest-client'
require 'json'
require 'ostruct'


class Array
  def normalize
    self.delete_if{|v| v.to_s.empty? }.sort
  end
end


module Helper

  module Rest
    class << self
      def to_json(str)
        return str if str.empty? or str == '""'
        OpenStruct.new(JSON.parse(str))
      end

      def get(uri, user_id:'123', authorization_header_key:'authorization', content_type:'image/jpeg', header:{}, to_json:true, follow_redirect:true)
        h = header.clone
        h.merge!(authorization_header_key=>user_id) if user_id and authorization_header_key
        h.merge!(content_type:content_type) if content_type
        r = if follow_redirect
              RestClient.get(uri, h)
            else
              RestClient.get(uri, h){|response, request, result, &block| response }
            end
        if to_json
          [to_json(r), r.headers, r.code]
        else
          [r, r.headers, r.code]
        end
      rescue => e
        yield(e) if block_given?
        raise e
      end

      def head(uri, user_id:'123', authorization_header_key:'authorization', content_type:'image/jpeg', header:{}, to_json:true)
        h = header.clone
        h.merge!(authorization_header_key=>user_id) if user_id and authorization_header_key
        h.merge!(content_type:content_type) if content_type
        r = RestClient.head(uri, h)
        [nil, r.headers, r.code]
      rescue => e
        yield(e) if block_given?
        raise e
      end

      def post(uri, params, user_id:'123', authorization_header_key:'authorization', content_type:'image/jpeg', header:{})
        h = header.clone
        h.merge!(authorization_header_key=>user_id) if user_id and authorization_header_key
        h.merge!(content_type:content_type) if content_type
        params = params.to_json if params.is_a? Hash
        r = RestClient.post(uri, params, h)
        [to_json(r), r.headers, r.code]
      rescue => e
        yield(e) if block_given?
        raise e
      end

      def put(uri, params, user_id:'123', authorization_header_key:'authorization', content_type:'image/jpeg', header:{})
        h = header.clone
        h.merge!(authorization_header_key=>user_id) if user_id and authorization_header_key
        h.merge!(content_type:content_type) if content_type
        params = params.to_json if params.is_a? Hash
        r = RestClient.put(uri, params, h)
        [to_json(r), r.headers, r.code]
      rescue => e
        yield(e) if block_given?
        raise e
      end

      def delete(uri, user_id:'123', authorization_header_key:'authorization', content_type:'image/jpeg', header:{})
        h = header.clone
        h.merge!(authorization_header_key=>user_id) if user_id and authorization_header_key
        h.merge!(content_type:content_type) if content_type
        r = RestClient.delete(uri, h)
        [to_json(r), r.headers, r.code]
      rescue => e
        yield(e) if block_given?
        raise e
      end

      def options(uri, origin:nil, ac_method:nil, ac_header:[], header:{})
        h = header.clone
        h.merge!(origin:origin) if origin
        h.merge!(access_control_request_method:ac_method) if ac_method
        h.merge!(access_control_request_headers:ac_header.join(', ')) if ac_header
        r = RestClient.options(uri, h)
        [r, r.headers, r.code]
      rescue => e
        yield(e) if block_given?
        raise e
      end
    end
  end
end
