require Rails.root.join('lib/token_verifier')

OmniAuth.config.request_validation_phase = TokenVerifier.new