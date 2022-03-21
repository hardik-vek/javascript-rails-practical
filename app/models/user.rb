# frozen_string_literal: true
class User < ApplicationRecord
  validate :authenticate, on: :update
  def authenticate
    u = User.find_by_id(self.id)
    if ((self.password != u.password) && (self.email != u.email))
      errors.add(:base, "Previous password is incorrect.")
    else
      self.password = u.password
    end
  end
end
