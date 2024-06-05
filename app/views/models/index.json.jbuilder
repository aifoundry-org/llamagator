# frozen_string_literal: true

json.array! @models, partial: 'models/model', as: :model
