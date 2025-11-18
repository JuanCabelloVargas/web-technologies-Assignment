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
  # Limpieza: Importante mantener este orden debido a las dependencias de claves foráneas
  Notification.delete_all
  UserBadge.delete_all
  ProgressLog.delete_all
  ChallengeInvite.delete_all
  ChallengeRequest.delete_all
  ChallengeParticipation.delete_all
  ChallengeComment.delete_all
  BookmarkedChallenge.delete_all
  Challenge.delete_all
  Badge.delete_all
  Category.delete_all
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

  member_a = User.create!(
    username: "nzo_member_a",
    email: "nzo_a@challengehub.test",
    role: :user,
    password: "Member123!",
    password_confirmation: "Member123!"
  )

  member_b = User.create!(
    username: "guest_user",
    email: "guest@challengehub.test",
    role: :user,
    password: "Member123!",
    password_confirmation: "Member123!"
  )

  runner_category   = Category.create!(name: "Running")
  strength_category = Category.create!(name: "Strength Training")


  challenge_public = Challenge.create!(
    name: "Sunrise 5K Challenge",
    description: "Log a 5K run every morning for the next week.",
    start_date: 1.day.from_now.beginning_of_day,
    end_date: 1.week.from_now.end_of_day,
    visibility: "public",
    status: "active",
    creator: creator,
    category: runner_category
  )

  challenge_private = Challenge.create!(
    name: "Advanced Strength Circuit",
    description: "Complete three strength circuits on alternating days. Invite-only.",
    start_date: 2.days.from_now.beginning_of_day,
    end_date: 10.days.from_now.end_of_day,
    visibility: "private",
    status: "upcoming",
    creator: creator,
    category: strength_category
  )

  challenge_completed = Challenge.create!(
    name: "10-Day Plank Mania",
    description: "Hold a plank for 5 minutes daily for 10 consecutive days.",
    start_date: 15.days.ago.beginning_of_day,
    end_date: 5.days.ago.end_of_day,
    visibility: "public",
    status: "completed",
    creator: member_a,
    category: strength_category
  )

  badge_runner = Badge.create!(
    code: "RUN-S",
    name: "Marathon Starter",
    description: "Awarded for completing any running challenge.",
    icon_url: "https://example.com/icons/runner.png"
  )

  badge_plank = Badge.create!(
    code: "STR-PLK",
    name: "Plank Master",
    description: "Awarded for completing the 10-Day Plank Mania challenge.",
    icon_url: "https://example.com/icons/plank.png"
  )

  BookmarkedChallenge.create!(user: member_a, challenge: challenge_public)
  BookmarkedChallenge.create!(user: member_a, challenge: challenge_private)


  ChallengeParticipation.create!(
    user: member_a,
    challenge: challenge_public,
    status: "active",
    joined_at: Time.now
  )

  ChallengeParticipation.create!(
    user: member_a,
    challenge: challenge_completed,
    status: "completed",
    joined_at: 15.days.ago
  )

  ChallengeParticipation.create!(
    user: member_b,
    challenge: challenge_public,
    status: "active",
    joined_at: Time.now
  )

  puts "Creating Comments..."
  ChallengeComment.create!(
    user: member_a,
    challenge: challenge_public,
    body: "Beggining this challenge tomorrow morning"
  )

  ChallengeComment.create!(
    user: creator,
    challenge: challenge_public,
    body: "Good way to start te day"
  )


  ProgressLog.create!(
    user: member_a,
    challenge: challenge_public,
    description: "Run 1: Made 5.2k run before breakfast.",
    progress_value: 5.2,
    unit: "km",
    logged_at: Time.now
  )

  ProgressLog.create!(
    user: member_a,
    challenge: challenge_completed,
    description: "Last made with planks!",
    progress_value: 300,
    unit: "seconds",
    logged_at: 10.days.ago.to_date
  )


  UserBadge.create!(
    user: member_a,
    badge: badge_plank,
    challenge: challenge_completed,
    awarded_at: 5.days.ago
  )

  UserBadge.create!(
    user: member_a,
    badge: badge_runner,
    challenge: challenge_public,
    awarded_at: Time.now.to_date
  )

  ChallengeRequest.create!(
    requester: member_b,
    challenge: challenge_private,
    status: :pending,
    message: "Me encantaría unirme a este circuito avanzado, he estado entrenando 6 meses."
  )

  ChallengeRequest.create!(
    requester: admin,
    challenge: challenge_private,
    status: :rejected,
    decided_by_id: creator.id,
    decided_at: Time.now,
    message: "Tested by admin",
  )

  ChallengeInvite.create!(
    inviter_id: creator.id,
    invitee_user_id: member_b.id,
    challenge: challenge_private,
    is_accepted: false
  )

  ChallengeInvite.create!(
    inviter_id: creator.id,
    invitee_user_id: admin.id,
    challenge: challenge_public,
    is_accepted: true,
    accepted_at: 1.day.from_now
  )


  Notification.create!(
    user: creator,
    title: "Nueva Solicitud de Acceso",
    body: "#{member_b.username} quiere unirse a #{challenge_private.name}.",
    notification_type: "challenge_request",
    related_type: "ChallengeRequest",
    related_id: ChallengeRequest.find_by(requester: member_b).id,
    is_read: false
  )

  Notification.create!(
    user: admin,
    title: "Invitación Aceptada",
    body: "¡Tu invitación a #{challenge_public.name} fue aceptada!",
    notification_type: "challenge_invite",
    related_type: "ChallengeInvite",
    related_id: ChallengeInvite.find_by(invitee_user_id: admin.id).id,
    is_read: true
  )

  Notification.create!(
    user: member_a,
    title: "¡Logro Desbloqueado!",
    body: "Has ganado la medalla #{badge_plank.name}!",
    notification_type: "badge_award",
    related_type: "UserBadge",
    related_id: UserBadge.find_by(user: member_a, badge: badge_plank).id,
    is_read: false
  )
end
