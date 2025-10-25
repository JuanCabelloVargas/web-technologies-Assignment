class ChangeDecidedByInChallengeRequests < ActiveRecord::Migration[8.0]
  def change
    change_column_null :challenge_requests, :decided_by_id, true
  end
end
