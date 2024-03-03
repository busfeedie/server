# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Google::Protobuf::EnumOptions`.
# Please instead update this file by running `bin/tapioca dsl Google::Protobuf::EnumOptions`.

class Google::Protobuf::EnumOptions
  sig do
    params(
      allow_alias: T.nilable(T::Boolean),
      deprecated: T.nilable(T::Boolean),
      deprecated_legacy_json_field_conflicts: T.nilable(T::Boolean),
      features: T.nilable(Google::Protobuf::FeatureSet),
      uninterpreted_option: T.nilable(T.any(Google::Protobuf::RepeatedField[Google::Protobuf::UninterpretedOption], T::Array[Google::Protobuf::UninterpretedOption]))
    ).void
  end
  def initialize(allow_alias: nil, deprecated: nil, deprecated_legacy_json_field_conflicts: nil, features: nil, uninterpreted_option: T.unsafe(nil)); end

  sig { returns(T::Boolean) }
  def allow_alias; end

  sig { params(value: T::Boolean).void }
  def allow_alias=(value); end

  sig { void }
  def clear_allow_alias; end

  sig { void }
  def clear_deprecated; end

  sig { void }
  def clear_deprecated_legacy_json_field_conflicts; end

  sig { void }
  def clear_features; end

  sig { void }
  def clear_uninterpreted_option; end

  sig { returns(T::Boolean) }
  def deprecated; end

  sig { params(value: T::Boolean).void }
  def deprecated=(value); end

  sig { returns(T::Boolean) }
  def deprecated_legacy_json_field_conflicts; end

  sig { params(value: T::Boolean).void }
  def deprecated_legacy_json_field_conflicts=(value); end

  sig { returns(T.nilable(Google::Protobuf::FeatureSet)) }
  def features; end

  sig { params(value: T.nilable(Google::Protobuf::FeatureSet)).void }
  def features=(value); end

  sig { returns(Google::Protobuf::RepeatedField[Google::Protobuf::UninterpretedOption]) }
  def uninterpreted_option; end

  sig { params(value: Google::Protobuf::RepeatedField[Google::Protobuf::UninterpretedOption]).void }
  def uninterpreted_option=(value); end
end
