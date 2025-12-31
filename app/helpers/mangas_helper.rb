module MangasHelper
  def temporary_image_url(location, chapter, image_name, expires_in: 1.hour)
    verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
    payload = { location:, chapter:, image_name: }
    token = verifier.generate(payload, expires_in:)
    chapter_image_path(location:, chapter:, image_name:, token:)
  end
end
