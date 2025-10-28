# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb
ActiveRecord::Base.transaction do
  puts "Cleaning tables…"
  Notification.delete_all
  UserBadge.delete_all
  ProgressLog.delete_all
  ChallengeInvite.delete_all
  ChallengeRequest.delete_all
  ChallengeParticipation.delete_all
  ChallengeComment.delete_all
  BookmarkedChallenge.delete_all
  Challenge.delete_all
  Category.delete_all
  Badge.delete_all
  User.delete_all

  admin_email = "admin@example.com"
  admin_username = "admin"

  admin = User.find_or_initialize_by(email: admin_email)

  admin.username = admin_username
  admin.role = :admin
  admin.password = "Admin123!"
  admin.password_confirmation = "Admin123!"

  admin.save!
end
