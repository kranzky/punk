# frozen_string_literal: true

# route: GET /plivo
PUNK.route('plivo') { present PUNK::PlivoStore }
