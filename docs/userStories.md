# FitChallenge — Assignment 1

###### Students: Juan Cabello, Sebastian Letelier, Enzo Palavicino.

## 1) User Stories

### 1.1 Participant User Stories
- As a participant, I want to create an account and log in securely, so that I can access the platform and manage my profile.
- As a participant, I want to update my profile information (name, avatar/profile picture, bio), so that my identity feels personal and recognizable.
- As a participant, I want to reset my password, so that I can recover access if I forget it.
- As a participant, I want to browse existing challenges by categories or filters, so that I can find challenges that interest me.
- As a participant, I want to view a detailed page for a challenge, so that I can see its description, rules, and my personal progress.
- As a participant, I want to join a challenge, so that I can start tracking my progress and earning points.
- As a participant, I want to log my daily or weekly progress, so that I can earn points and contribute to my ranking.
- As a participant, I want to see the leaderboard for a challenge, so that I can know my ranking and compare myself with others.
- As a participant, I want to see a history of my logged progress, so that I can track how I improved over time.
- As a participant, I want to quit a challenge, so that I can stop participating if I lose interest.
- As a participant, I want to earn badges or achievements, so that I feel rewarded for my consistency.
- As a participant, I want to receive optional email or in-app notifications about my progress or challenge updates, so that I can stay motivated and engaged.
- As a participant, I want to view a badge gallery, so that I can see what achievements are possible.
- As a user, I want to search challenges by keywords, so that I can quickly find the one relevant to me.
- As a user, I want to bookmark or save challenges for later, so that I can join them when I’m ready.
- As a participant, I want to receive reminders to log my daily progress, so that I don’t forget.
- As a participant, I want to invite friends to challenges, so that I can motivate them.
- As a user, I want to be able to delete my account and personal data, so that I have control over my privacy.
- As a user, I want the application to be multi-device, so that I can use it on my phone, tablet, or PC.
- As a user, I want to be able to comment on challenges, so that I can share experiences.
- As a user, I want to compare my historical progress with graphs, so that I can visualize my improvements.

### 1.2 Challenge Creator User Stories
- As a challenge creator, I want to define the details of a new challenge (name, description, duration), so that other users can understand and join it.
- As a challenge creator, I want to define the point allocation rules for my challenge, so that participants are rewarded for their consistent progress.
- As a challenge creator, I want to edit or update my challenge details, so that I can fix mistakes or adjust the rules if needed.
- As a challenge creator, I want to remove or close my challenge, so that I can stop it when it ends or if it is no longer relevant.
- As a challenge creator, I want to view the list of participants and their progress, so that I can monitor engagement in my challenge.
- As a challenge creator, I want to manage and oversee the challenge I created, so that I can ensure it runs smoothly and stays relevant.
- As a challenge creator, I want to set my challenges as public or private, so that I can control who can join.
- As a challenge creator, I want to approve or decline join requests (for private challenges), so that I control who participates.
- As a challenge creator, I want to add tags or categories to my challenge, so that users can easily find it.
- As a challenge creator, I want to highlight top participants, so that I can encourage competition in the challenge.
- As a challenge creator, I want to schedule my challenge to start at a future date, so that participants can prepare in advance.

### 1.3 Administrator User Stories
- As an administrator, I want to manage all users and their roles (participant, creator, etc.), so that I can oversee the community and its members.
- As an administrator, I want to assign or revoke challenge creator permissions to users, so that roles are properly managed.
- As an administrator, I want to suspend or delete users who break the rules, so that the community remains safe and respectful.
- As an administrator, I want to oversee all challenges on the platform, so that I can ensure they follow community guidelines.
- As an administrator, I want to delete inappropriate challenges, so that the platform maintains quality and compliance.
- As an administrator, I want to manage overall system settings, so that I can maintain the platform’s stability and functionality.
- As an administrator, I want to view platform-wide statistics (total users, active challenges, participation rates), so that I can measure engagement and growth.
- As an administrator, I want to set password/security policies, so that user accounts are protected.

---

## 2) Data Model

### 2.1 Entities
- **Users**: People who use the app (role: admin/member).
- **Challenges**: Challenges created by a user.
- **Challenge_participants**: A user’s enrollment in a challenge (status and accumulated points).
- **Progress_entries**: Individual progress logs by participants; points are awarded based on rules.
- **Badges**: System-defined achievements (gamification).
- **User_badges**: Association table linking badges to users.
- **Categories**: Classification for challenges.

*(Optional but commonly needed: `Comments` for challenge discussions, `Tags` & `Challenge_tags` for discovery, `Point_rules` and `Points_ledger` for scoring, `Notifications` for reminders.)*

### 2.2 Relationships
- One **User** creates many **Challenges**.
- One **User** participates in many **Challenges** through **Challenge_participants**.
- Each **Progress_entry** belongs to a **Challenge_participant** (and, by extension, a specific challenge and user).
- **Badges** are assigned to users via **User_badges**.
- Each **Challenge** can belong to a **Category**.


### 2.3 Rules
- `challenges.start_date <= challenges.end_date`.
- Each email must be unique across **Users**.
- Uniqueness on `(user_id, challenge_id)` in **Challenge_participants**.
- `progress_entries.logged_on` must fall within `[challenge.start_date, challenge.end_date]`.
- **Leaderboard** for a challenge = sum of points from **Progress_entries** (or **Points_ledger** if using detailed accounting).
- The comment in a challenge cannot have a reply.
- The invitation between partners It's made via URL.
- Invitations can be accepted only by creator or Administrator.


---


### Entities Diagram:
![diagram](images/diagram.png)
