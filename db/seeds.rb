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

  puts " Creating users…"
  u1 = User.create!(username: "alice", email: "alice@example.com", role: "member", password: "secret", avatar_url: nil)
  u2 = User.create!(username: "bob",   email: "bob@example.com",   role: "member", password: "secret", avatar_url: nil)
  admin = User.create!(username: "admin", email: "admin@example.com", role: "admin", password: "admin123", avatar_url: nil)

  puts "Creating category…"
  running = Category.create!(name: "Running")

  puts "Creating badges…"
  b5  = Badge.create!(
    code: "RUN_5K",
    name: "Run 5K",
    description: "Awarded for running 5 kilometers",
    icon_url: "https://via.placeholder.com/60?text=5K"
  )
  b10 = Badge.create!(
    code: "RUN_10K",
    name: "Run 10K",
    description: "Awarded for running 10 kilometers",
    icon_url: "https://via.placeholder.com/60?text=10K"
  )

  puts "🏃 Creating challenges…"
  c5 = Challenge.create!(
    name: "5K Weekly Run",
    description: "Complete a 5 km run this week.",
    start_date: Time.current.beginning_of_day,
    end_date:   7.days.from_now.end_of_day,
    visibility: "public",
    status:     "active",
    creator: u1,
    category: running
  )

  c10 = Challenge.create!(
    name: "10K Weekend Run",
    description: "Run 10 km this weekend.",
    start_date: Time.current.beginning_of_day,
    end_date:   10.days.from_now.end_of_day,
    visibility: "public",
    status:     "active",
    creator: u2,
    category: running
  )

  puts "Participations…"
  ChallengeParticipation.create!(challenge: c5, user: u1, status: "owner", joined_at: Time.current, total_points: 0)
  ChallengeParticipation.create!(challenge: c10, user: u2, status: "owner", joined_at: Time.current, total_points: 0)
  ChallengeParticipation.create!(challenge: c5, user: u2, status: "joined", joined_at: Time.current, total_points: 15)

  puts "Bookmarks…"
  BookmarkedChallenge.create!(user: u1, challenge: c10)
  BookmarkedChallenge.create!(user: u2, challenge: c5)

  puts "Requests (decided)…"
  req1 = ChallengeRequest.create!(
    challenge: c5,
    requester: u2,
    status: "accepted",
    message: "I'd like to join and improve my 5K time!",
    decided_by: admin,
    decided_at: Time.current
  )

  req2 = ChallengeRequest.create!(
    challenge: c10,
    requester: u1,
    status: "accepted",
    message: "Count me in for the 10K!",
    decided_by: admin,
    decided_at: Time.current
  )

  puts "Comments…"
  ChallengeComment.create!(challenge: c5, user: u2, body: "Did a warm-up 2K today, going for 5K tomorrow!", is_deleted: false)
  ChallengeComment.create!(challenge: c10, user: u1, body: "Anyone running at the park on Saturday?", is_deleted: false)

  puts "Invites…"
  ChallengeInvite.create!(
    challenge: c5,
    inviter: u1,
    invitee_user: admin,
    is_accepted: false,
    accepted_at: Time.current
  )

  ChallengeInvite.create!(
    challenge: c10,
    inviter: u2,
    invitee_user: u1,
    is_accepted: true,
    accepted_at: Time.current
  )


  puts "Progress logs…"
  ProgressLog.create!(user: u2, challenge: c5, description: "Morning jog", progress_value: 5.0, unit: "km", logged_at: Time.current)
  ProgressLog.create!(user: u1, challenge: c10, description: "Long run prep (8km)", progress_value: 8.0, unit: "km", logged_at: Time.current)

  puts "User badges (awards)…"
  ub1 = UserBadge.create!(user: u2, badge: b5, challenge: c5, awarded_at: Time.current)
  ub2 = UserBadge.create!(user: u1, badge: b10, challenge: c10, awarded_at: Time.current)

  puts "Notifications…"
  Notification.create!(user: u2, title: "Badge earned!", body: "You earned the Run 5K badge.", notification_type: "badge_awarded", related: ub1, is_read: false)
  Notification.create!(user: u1, title: "Badge earned!", body: "You earned the Run 10K badge.", notification_type: "badge_awarded", related: ub2, is_read: false)
  Notification.create!(user: admin, title: "You were invited", body: "alice invited you to 5K Weekly Run.", notification_type: "challenge_invite", related: c5, is_read: false)

  puts "Seed completed successfully!"
end
