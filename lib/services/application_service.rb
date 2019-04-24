# frozen_string_literal: true

# Base service
class ApplicationService
  def self.call(*args)
    new.call(*args)
  end
end
