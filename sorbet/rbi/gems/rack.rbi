# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: false
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/rack/all/rack.rbi
#
# rack-3.0.8

module Rack
  def self.release; end
  def self.version; end
end
module Rack::Auth
end
class Rack::QueryParser
  def _normalize_params(params, name, v, depth); end
  def initialize(params_class, _key_space_limit = nil, param_depth_limit); end
  def make_params; end
  def new_depth_limit(param_depth_limit); end
  def normalize_params(params, name, v, _depth = nil); end
  def param_depth_limit; end
  def params_hash_has_key?(hash, key); end
  def params_hash_type?(obj); end
  def parse_nested_query(qs, separator = nil); end
  def parse_query(qs, separator = nil, &unescaper); end
  def self.make_default(_key_space_limit = nil, param_depth_limit); end
  def unescape(string, encoding = nil); end
end
class Rack::QueryParser::ParameterTypeError < TypeError
end
class Rack::QueryParser::InvalidParameterError < ArgumentError
end
class Rack::QueryParser::ParamsTooDeepError < RangeError
end
class Rack::QueryParser::Params
  def [](key); end
  def []=(key, value); end
  def initialize; end
  def key?(key); end
  def to_h; end
  def to_params_hash; end
end
module Rack::Mime
  def match?(value, matcher); end
  def mime_type(ext, fallback = nil); end
  def self.match?(value, matcher); end
  def self.mime_type(ext, fallback = nil); end
end
class Rack::Headers < Hash
  def [](key); end
  def []=(key, value); end
  def assoc(key); end
  def compare_by_identity; end
  def delete(key); end
  def dig(key, *a); end
  def downcase_key(key); end
  def except(*a); end
  def fetch(key, *default, &block); end
  def fetch_values(*a); end
  def has_key?(key); end
  def include?(key); end
  def invert; end
  def key?(key); end
  def member?(key); end
  def merge!(hash, &block); end
  def merge(hash, &block); end
  def reject(&block); end
  def replace(hash); end
  def select(&block); end
  def self.[](*items); end
  def slice(*a); end
  def store(key, value); end
  def to_proc; end
  def transform_keys!; end
  def transform_keys(&block); end
  def transform_values(&block); end
  def update(hash, &block); end
  def values_at(*keys); end
end
module Rack::Utils
  def add_cookie_to_header(header, key, value); end
  def add_remove_cookie_to_header(header, key, value = nil); end
  def best_q_match(q_value_header, available_mimes); end
  def build_nested_query(value, prefix = nil); end
  def build_query(params); end
  def byte_ranges(env, size); end
  def clean_path_info(path_info); end
  def clock_time; end
  def delete_cookie_header!(headers, key, value = nil); end
  def delete_set_cookie_header!(header, key, value = nil); end
  def delete_set_cookie_header(key, value = nil); end
  def escape(s); end
  def escape_html(string); end
  def escape_path(s); end
  def forwarded_values(forwarded_header); end
  def get_byte_ranges(http_range, size); end
  def make_delete_cookie_header(header, key, value); end
  def parse_cookies(env); end
  def parse_cookies_header(value); end
  def parse_nested_query(qs, d = nil); end
  def parse_query(qs, d = nil, &unescaper); end
  def q_values(q_value_header); end
  def rfc2822(time); end
  def secure_compare(a, b); end
  def select_best_encoding(available_encodings, accept_encoding); end
  def self.add_cookie_to_header(header, key, value); end
  def self.add_remove_cookie_to_header(header, key, value = nil); end
  def self.best_q_match(q_value_header, available_mimes); end
  def self.build_nested_query(value, prefix = nil); end
  def self.build_query(params); end
  def self.byte_ranges(env, size); end
  def self.clean_path_info(path_info); end
  def self.clock_time; end
  def self.default_query_parser; end
  def self.default_query_parser=(arg0); end
  def self.delete_cookie_header!(headers, key, value = nil); end
  def self.delete_set_cookie_header!(header, key, value = nil); end
  def self.delete_set_cookie_header(key, value = nil); end
  def self.escape(s); end
  def self.escape_html(string); end
  def self.escape_path(s); end
  def self.forwarded_values(forwarded_header); end
  def self.get_byte_ranges(http_range, size); end
  def self.key_space_limit; end
  def self.key_space_limit=(v); end
  def self.make_delete_cookie_header(header, key, value); end
  def self.multipart_file_limit; end
  def self.multipart_file_limit=(arg0); end
  def self.multipart_part_limit; end
  def self.multipart_part_limit=(arg0); end
  def self.multipart_total_part_limit; end
  def self.multipart_total_part_limit=(arg0); end
  def self.param_depth_limit; end
  def self.param_depth_limit=(v); end
  def self.parse_cookies(env); end
  def self.parse_cookies_header(value); end
  def self.parse_nested_query(qs, d = nil); end
  def self.parse_query(qs, d = nil, &unescaper); end
  def self.q_values(q_value_header); end
  def self.rfc2822(time); end
  def self.secure_compare(a, b); end
  def self.select_best_encoding(available_encodings, accept_encoding); end
  def self.set_cookie_header!(headers, key, value); end
  def self.set_cookie_header(key, value); end
  def self.status_code(status); end
  def self.unescape(s, encoding = nil); end
  def self.unescape_path(s); end
  def self.valid_path?(path); end
  def set_cookie_header!(headers, key, value); end
  def set_cookie_header(key, value); end
  def status_code(status); end
  def unescape(s, encoding = nil); end
  def unescape_path(s); end
  def valid_path?(path); end
end
class Rack::Utils::Context
  def app; end
  def call(env); end
  def context(env, app = nil); end
  def for; end
  def initialize(app_f, app_r); end
  def recontext(app); end
end
class Rack::Utils::HeaderHash < Hash
  def self.[](headers); end
  def self.allocate; end
  def self.new(hash = nil); end
end
class Rack::MediaType
  def self.params(content_type); end
  def self.strip_doublequotes(str); end
  def self.type(content_type); end
end
class Rack::Request
  def delete_param(k); end
  def initialize(env); end
  def params; end
  def self.forwarded_priority; end
  def self.forwarded_priority=(arg0); end
  def self.ip_filter; end
  def self.ip_filter=(arg0); end
  def self.x_forwarded_proto_priority; end
  def self.x_forwarded_proto_priority=(arg0); end
  def update_param(k, v); end
  include Rack::Request::Env
  include Rack::Request::Helpers
end
module Rack::Request::Env
  def add_header(key, v); end
  def delete_header(name); end
  def each_header(&block); end
  def env; end
  def fetch_header(name, &block); end
  def get_header(name); end
  def has_header?(name); end
  def initialize(env); end
  def initialize_copy(other); end
  def set_header(name, v); end
end
module Rack::Request::Helpers
  def GET; end
  def POST; end
  def [](key); end
  def []=(key, value); end
  def accept_encoding; end
  def accept_language; end
  def allowed_scheme(header); end
  def authority; end
  def base_url; end
  def body; end
  def content_charset; end
  def content_length; end
  def content_type; end
  def cookies; end
  def default_session; end
  def delete?; end
  def delete_param(k); end
  def form_data?; end
  def forwarded_authority; end
  def forwarded_for; end
  def forwarded_port; end
  def forwarded_priority; end
  def forwarded_scheme; end
  def fullpath; end
  def get?; end
  def get_http_forwarded(token); end
  def head?; end
  def host; end
  def host_authority; end
  def host_with_port(authority = nil); end
  def hostname; end
  def ip; end
  def link?; end
  def logger; end
  def media_type; end
  def media_type_params; end
  def options?; end
  def params; end
  def parse_http_accept_header(header); end
  def parse_multipart; end
  def parse_query(qs, d = nil); end
  def parseable_data?; end
  def patch?; end
  def path; end
  def path_info; end
  def path_info=(s); end
  def port; end
  def post?; end
  def put?; end
  def query_parser; end
  def query_string; end
  def referer; end
  def referrer; end
  def reject_trusted_ip_addresses(ip_addresses); end
  def request_method; end
  def scheme; end
  def script_name; end
  def script_name=(s); end
  def server_authority; end
  def server_name; end
  def server_port; end
  def session; end
  def session_options; end
  def split_authority(authority); end
  def split_header(value); end
  def ssl?; end
  def trace?; end
  def trusted_proxy?(ip); end
  def unlink?; end
  def update_param(k, v); end
  def url; end
  def user_agent; end
  def values_at(*keys); end
  def wrap_ipv6(host); end
  def x_forwarded_proto_priority; end
  def xhr?; end
end
class Rack::Response
  def [](key); end
  def []=(key, value); end
  def body; end
  def body=(arg0); end
  def chunked?; end
  def close; end
  def delete_header(key); end
  def each(&callback); end
  def empty?; end
  def finish(&block); end
  def get_header(key); end
  def has_header?(key); end
  def header; end
  def headers; end
  def initialize(body = nil, status = nil, headers = nil); end
  def length; end
  def length=(arg0); end
  def no_entity_body?; end
  def redirect(target, status = nil); end
  def self.[](status, headers, body); end
  def set_header(key, value); end
  def status; end
  def status=(arg0); end
  def to_a(&block); end
  def write(chunk); end
  include Rack::Response::Helpers
end
module Rack::Response::Helpers
  def accepted?; end
  def add_header(key, value); end
  def append(chunk); end
  def bad_request?; end
  def buffered_body!; end
  def cache!(duration = nil, directive: nil); end
  def cache_control; end
  def cache_control=(value); end
  def client_error?; end
  def content_length; end
  def content_type; end
  def content_type=(content_type); end
  def created?; end
  def delete_cookie(key, value = nil); end
  def do_not_cache!; end
  def etag; end
  def etag=(value); end
  def forbidden?; end
  def include?(header); end
  def informational?; end
  def invalid?; end
  def location; end
  def location=(location); end
  def media_type; end
  def media_type_params; end
  def method_not_allowed?; end
  def moved_permanently?; end
  def no_content?; end
  def not_acceptable?; end
  def not_found?; end
  def ok?; end
  def precondition_failed?; end
  def redirect?; end
  def redirection?; end
  def request_timeout?; end
  def server_error?; end
  def set_cookie(key, value); end
  def set_cookie_header; end
  def set_cookie_header=(value); end
  def successful?; end
  def unauthorized?; end
  def unprocessable?; end
end
class Rack::Response::Raw
  def delete_header(key); end
  def get_header(key); end
  def has_header?(key); end
  def headers; end
  def initialize(status, headers); end
  def set_header(key, value); end
  def status; end
  def status=(arg0); end
  include Rack::Response::Helpers
end
class Rack::MockResponse < Rack::Response
  def =~(other); end
  def body; end
  def cookie(name); end
  def cookies; end
  def empty?; end
  def errors; end
  def errors=(arg0); end
  def identify_cookie_attributes(cookie_filling); end
  def initialize(status, headers, body, errors = nil); end
  def match(other); end
  def original_headers; end
  def parse_cookies_from_header; end
  def self.[](*arg0, **); end
end
class Rack::MockRequest
  def delete(uri, opts = nil); end
  def get(uri, opts = nil); end
  def head(uri, opts = nil); end
  def initialize(app); end
  def options(uri, opts = nil); end
  def patch(uri, opts = nil); end
  def post(uri, opts = nil); end
  def put(uri, opts = nil); end
  def request(method = nil, uri = nil, opts = nil); end
  def self.env_for(uri = nil, opts = nil); end
  def self.parse_uri_rfc2396(uri); end
end
class Rack::MockRequest::FatalWarning < RuntimeError
end
class Rack::MockRequest::FatalWarner
  def flush; end
  def puts(warning); end
  def string; end
  def write(warning); end
end
class Rack::Runtime
end
class Rack::BodyProxy
end
class Rack::Sendfile
end
class Rack::MethodOverride
end
class Rack::Head
end
class Rack::ConditionalGet
end
class Rack::ETag
end
class Rack::TempfileReaper
end
class Rack::Files
end
class Rack::Files::BaseIterator
end
class Rack::Files::Iterator < Rack::Files::BaseIterator
end
class Rack::Cascade
end
class Rack::Chunked
  include Rack::Utils
end
class Rack::Chunked::Body
end
class Rack::Chunked::TrailerBody < Rack::Chunked::Body
end
class Rack::CommonLogger
end
class Rack::Config
end
class Rack::ContentLength
  include Rack::Utils
end
class Rack::ContentType
  include Rack::Utils
end
class Rack::Events
end
module Rack::Events::Abstract
end
class Rack::Events::EventedBodyProxy < Rack::BodyProxy
end
class Rack::Events::BufferedResponse < Rack::Response::Raw
end
class Rack::Deflater
end
class Rack::Deflater::GzipStream
end
class Rack::Directory
end
class Rack::Directory::DirectoryBody < Anonymous_Struct_16
end
class Rack::ForwardRequest < Exception
end
class Rack::Recursive
end
class Rack::Lint
end
class Rack::Lint::LintError < RuntimeError
end
class Rack::Lint::Wrapper
end
class Rack::Lint::Wrapper::InputWrapper
end
class Rack::Lint::Wrapper::ErrorWrapper
end
class Rack::Lint::Wrapper::StreamWrapper
  extend Forwardable
end
class Rack::Lock
end
class Rack::Logger
end
class Rack::NullLogger
end
class Rack::Reloader
end
module Rack::Reloader::Stat
end
class Rack::RewindableInput
end
class Rack::RewindableInput::Middleware
end
class Rack::URLMap
end
class Rack::Builder
end
class Rack::ShowExceptions
end
class Rack::ShowStatus
end
class Rack::Static
end
module Rack::Multipart
end
class Rack::Multipart::MultipartPartLimitError < Errno::EMFILE
end
class Rack::Multipart::MultipartTotalPartLimitError < StandardError
end
class Rack::Multipart::EmptyContentError < EOFError
end
class Rack::Multipart::Error < StandardError
end
class Rack::Multipart::Parser
end
class Rack::Multipart::Parser::BoundedIO
end
class Rack::Multipart::Parser::Collector
  include Enumerable
end
class Rack::Multipart::Parser::Collector::MimePart < Anonymous_Struct_17
end
class Rack::Multipart::Parser::Collector::BufferPart < Rack::Multipart::Parser::Collector::MimePart
end
class Rack::Multipart::Parser::Collector::TempfilePart < Rack::Multipart::Parser::Collector::MimePart
end
class Rack::Multipart::UploadedFile
end
class Rack::Multipart::Generator
end
class Rack::Auth::AbstractHandler
end
class Rack::Auth::AbstractRequest
end
class Rack::Auth::Basic < Rack::Auth::AbstractHandler
end
class Rack::Auth::Basic::Request < Rack::Auth::AbstractRequest
end
module Rack::Auth::Digest
end
class Rack::Auth::Digest::Nonce
end
class Rack::Auth::Digest::Params < Hash
end
class Rack::Auth::Digest::Request < Rack::Auth::AbstractRequest
end
class Rack::Auth::Digest::MD5 < Rack::Auth::AbstractHandler
end
