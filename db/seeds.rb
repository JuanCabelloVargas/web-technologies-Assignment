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

  admin = User.create!(
    username: "admin",
    email: "admin@example.com",
    role: :admin,
    password: "Admin123!",
    password_confirmation: "Admin123!"
  )

  creator = User.create!(
    username: "coach_nzo",
    email: "coach@challengehub.test",
    role: :creator,
    password: "Creator123!",
    password_confirmation: "Creator123!"
  )

  member = User.create!(
    username: "nzo_member",
    email: "nzo@challengehub.test",
    role: :user,
    password: "Member123!",
    password_confirmation: "Member123!"
  )

  runner_category   = Category.create!(name: "Running")
  strength_category = Category.create!(name: "Strength Training")

  Challenge.create!(
    name: "Sunrise 5K Challenge",
    description: "Log a 5K run every morning for the next week.",
    start_date: 1.day.from_now.beginning_of_day,
    end_date: 1.week.from_now.end_of_day,
    visibility: "public",
    status: "active",
    creator: creator,
    category: runner_category
  )

  Challenge.create!(
    name: "Strength Circuit Sprint",
    description: "Complete three strength circuits on alternating days.",
    start_date: 2.days.from_now.beginning_of_day,
    end_date: 10.days.from_now.end_of_day,
    visibility: "private",
    status: "upcoming",
    creator: creator,
    category: strength_category
  )
end
