# frozen_string_literal: true

class AvatarUploader < BaseUploader
  plugin :determine_mime_type
  plugin :validation_helpers, default_messages: {
    max_size: ->(_max) { I18n.t('errors.file.max_size', max: '5 MB') },
    mime_type_inclusion: lambda { |list|
                           I18n.t('errors.file.mime_type_inclusion', list: list.join(', '))
                         },
    extension_inclusion: lambda { |list|
                           I18n.t('errors.file.extension_inclusion', list: list.join(', '))
                         }
  }

  Attacher.validate do
    validate_max_size 5 * 1024 * 1024
    validate_mime_type_inclusion %w[image/jpg image/jpeg image/png]
    validate_extension_inclusion %w[jpg jpeg png]
  end
end
