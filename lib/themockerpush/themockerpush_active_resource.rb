require 'active_resource'
require 'cgi'
require 'openssl'
require 'net/http'

class ThemockerpushActiveResource < ActiveResource::Base
  self.site = "http://themockerpush.com/api/:api_key"  
  self.format = :json
  
  def initialize(params)
    super(params.merge({:api_key => Themockerpush::API_KEY}))
  end
  
  class << self
      def element_path(id, prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{id}#{query_string(query_options)}"
      end

      def collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end
      
      def custom_method_collection_url(method_name, options = {})
        prefix_options, query_options = split_options(options)
        "#{prefix(prefix_options)}#{collection_name}/#{method_name}#{query_string(query_options)}"
      end        
      
  end 
  
end

module ActiveResource
  class Connection
    
    [:put, :post].each do |method_name|
      alias_method "original_#{method_name}", method_name
      define_method method_name.to_s do |path, body, headers|
        with_hmac_authentication(path, body) do |authenticated_path, authenticated_body|
          self.send("original_#{method_name}", authenticated_path, authenticated_body || '', headers || {})
        end
      end
    end
        
    private
    
    def digest
      @digest ||= OpenSSL::Digest::Digest.new('sha1')
    end
    
    def build_hmac_token_for_body(body = '')
      OpenSSL::HMAC.hexdigest digest, Themockerpush::SECRET_KEY, body
    end
    
    def path_by_appending_parameters_hash(path, parameters_hash)
      parameters_query = parameters_hash.to_query
      path + (path.include?('?') ? "&#{parameters_query}" : "?#{parameters_query}")
    end
    
    def with_hmac_authentication(path, body = '')
      path_with_hmac = path_by_appending_parameters_hash(path, {:hmac_token => build_hmac_token_for_body(body)})
      yield path_with_hmac, body
    end
  end
  
end