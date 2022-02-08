class UsersController < ApplicationController
  validates :key, uniqueness: { case_sensitive: false }
end