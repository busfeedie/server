# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Google::Protobuf::FeatureSet::RepeatedFieldEncoding`.
# Please instead update this file by running `bin/tapioca dsl Google::Protobuf::FeatureSet::RepeatedFieldEncoding`.

module Google::Protobuf::FeatureSet::RepeatedFieldEncoding
  class << self
    sig { returns(Google::Protobuf::EnumDescriptor) }
    def descriptor; end

    sig { params(number: Integer).returns(T.nilable(Symbol)) }
    def lookup(number); end

    sig { params(symbol: Symbol).returns(T.nilable(Integer)) }
    def resolve(symbol); end
  end
end

Google::Protobuf::FeatureSet::RepeatedFieldEncoding::EXPANDED = 2
Google::Protobuf::FeatureSet::RepeatedFieldEncoding::PACKED = 1
Google::Protobuf::FeatureSet::RepeatedFieldEncoding::REPEATED_FIELD_ENCODING_UNKNOWN = 0
