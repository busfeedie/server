# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `opentelemetry-instrumentation-graphql` gem.
# Please instead update this file by running `bin/tapioca gem opentelemetry-instrumentation-graphql`.

# OpenTelemetry is an open source observability framework, providing a
# general-purpose API, SDK, and related tools required for the instrumentation
# of cloud-native software, frameworks, and libraries.
#
# The OpenTelemetry module provides global accessors for telemetry objects.
# See the documentation for the `opentelemetry-api` gem for details.
#
# source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation.rb#13
module OpenTelemetry
  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#36
  def error_handler; end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#27
  def error_handler=(_arg0); end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#44
  def handle_error(exception: T.unsafe(nil), message: T.unsafe(nil)); end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#30
  def logger; end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#27
  def logger=(_arg0); end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#69
  def propagation; end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#27
  def propagation=(_arg0); end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#64
  def tracer_provider; end

  # source://opentelemetry-api/1.2.5/lib/opentelemetry.rb#52
  def tracer_provider=(provider); end
end

# Instrumentation should be able to handle the case when the library is not installed on a user's system.
#
# source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation.rb#15
module OpenTelemetry::Instrumentation
  # source://opentelemetry-registry/0.3.0/lib/opentelemetry/instrumentation.rb#21
  def registry; end
end

# Contains the OpenTelemetry instrumentation for the GraphQL gem
#
# source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql.rb#13
module OpenTelemetry::Instrumentation::GraphQL; end

# The Instrumentation class contains logic to detect and install the GraphQL instrumentation
#
# source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql/instrumentation.rb#13
class OpenTelemetry::Instrumentation::GraphQL::Instrumentation < ::OpenTelemetry::Instrumentation::Base
  # @return [Boolean]
  #
  # source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql/instrumentation.rb#36
  def supports_legacy_tracer?; end

  # @return [Boolean]
  #
  # source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql/instrumentation.rb#40
  def supports_new_tracer?; end

  private

  # source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql/instrumentation.rb#72
  def gem_version; end

  # source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql/instrumentation.rb#88
  def install_new_tracer(config = T.unsafe(nil)); end

  # source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql/instrumentation.rb#76
  def install_tracer(config = T.unsafe(nil)); end
end

# source://opentelemetry-instrumentation-graphql//lib/opentelemetry/instrumentation/graphql/version.rb#10
OpenTelemetry::Instrumentation::GraphQL::VERSION = T.let(T.unsafe(nil), String)
