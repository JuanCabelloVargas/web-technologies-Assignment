# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, [ Category, Challenge, ChallengeParticipation, ProgressLog, Badge, UserBadge, ChallengeComment, Notification ]

      if user.persisted?
        can :read, User, id: user.id
        can :update, User, id: user.id

        can :create, [ ChallengeRequest, ChallengeInvite, ChallengeComment, BookmarkedChallenge, ProgressLog ]
        can [ :update, :destroy ], ChallengeComment, user_id: user.id
        can [ :index, :create, :destroy, :toggle ], BookmarkedChallenge, user_id: user.id
        can :mark_as_read, Notification, user_id: user.id

        can :destroy, UserBadge, user_id: user.id
        can :read, UserBadge, user_id: user.id
        can :create, UserBadge do |userbadge|
          userbadge.user_id == user.id
        end

        if user.creator?
          can :create, Challenge
          can [ :update, :destroy ], Challenge, creator_id: user.id
        end

      end
    end
  end
end
