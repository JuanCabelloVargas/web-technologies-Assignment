# FitChallenge – Assignment 1 Documentation

## 1. User Stories

### 1.1 Participant User Stories
- As a participant, I want to create an account and log in securely, so that I can access the platform and manage my profile.  
- As a participant, I want to update my profile information (name, avatar or profile pic, bio), so that my identity feels personal and recognizable.  
- As a participant, I want to reset my password, so that I can recover access if I forget it.  
- As a participant, I want to browse existing challenges by categories or filters, so that I can find challenges that interest me.  
- As a participant, I want to view a detailed page for a challenge, so that I can see its description, rules, and my personal progress.  
- As a participant, I want to join a challenge, so that I can start tracking my progress and earning points.  
- As a participant, I want to log my daily or weekly progress, so that I can earn points and contribute to my ranking.  
- As a participant, I want to see the leaderboard for a challenge, so that I can know my ranking and compare myself with others.  
- As a participant, I want to see a history of my logged progress, so that I can track how I improved over time.  
- As a participant, I want to leave or quit a challenge, so that I can stop participating if I lose interest.  
- As a participant, I want to earn badges or achievements, so that I feel rewarded for my consistency.  
- As a participant, I want to receive optional email or in-app notifications about my progress or challenge updates, so that I can stay motivated and engaged.  
- As a participant, I want to unlock milestone badges, so that I feel recognized for my streak.  
- As a participant, I want to view a badge gallery, so that I can see what achievements are possible.  
- As a user, I want to search challenges by keywords, so that I can quickly find the one relevant to me.  
- As a user, I want to bookmark or save challenges for later, so that I can join them when I’m ready.  
- As a participant, I want to receive reminders to log my daily progress, so that I don’t forget.  
- As a participant, I want to invite friends to challenges, so that I motivate them.  
- As a user, I want to pay using different methods (credit card, debit card, bank transfer), for greater convenience.  
- As a user, I want to receive an electronic receipt after each payment, so that I have proof of it.  
- As a user, I want to be able to download invoices in PDF, so that I can use them for accounting purposes.  
- As a user, I want to be able to delete my account and personal data, so that I have control over my privacy.  
- As a user, I want the application to be multi-device, so that I can use it on my phone, tablet, or PC.  
- As a user, I want to be able to comment on challenges, so that I can share experiences.  
- As a user, I want to be able to provide feedback or suggestions on the system, so that I can contribute to improvements.  
- As a user, I want to compare my historical progress with graphs, so that I can visualize my improvements.  
- As a user, I want to receive recommendations for new challenges based on my interests, so that I can keep growing.  

---

### 1.2 Challenge Creator User Stories
- As a challenge creator, I want to define the details of a new challenge, including its name, description, and duration, so that other users can understand and join it.  
- As a challenge creator, I want to define the point allocation rules for my challenge, so that participants are rewarded for their consistent progress.  
- As a challenge creator, I want to edit or update my challenge details, so that I can fix mistakes or adjust the rules if needed.  
- As a challenge creator, I want to remove or close my challenge, so that I can stop it when it ends or if it is no longer relevant.  
- As a challenge creator, I want to view the list of participants and their progress, so that I can monitor engagement in my challenge.  
- As a challenge creator, I want to award special recognition (badges or shout-outs) to participants, so that I can encourage engagement.  
- As a challenge creator, I want to manage and oversee the challenge I created, so that I can ensure it runs smoothly and according to its rules.  
- As a challenge creator, I want to set my challenges as public or private, so that I can control who can join.  
- As a challenge creator, I want to approve or decline join requests (for private challenges), so that I control who participates.  
- As a challenge creator, I want to add tags or categories to my challenge, so that users can easily find it.  
- As a challenge creator, I want to highlight top participants, so that I can encourage competition in the challenge.  
- As a challenge creator, I want to schedule my challenge to start at a future date, so that participants can prepare in advance.  
- As a challenge creator, I want to create templates for challenges, so that I can create new ones quickly.  

---

### 1.3 Administrator User Stories
- As an administrator, I want to manage all users and their roles (participant, creator, etc.), so that I can oversee the community and its members.  
- As an administrator, I want to assign or revoke challenge creator permissions to users, so that roles are properly managed.  
- As an administrator, I want to suspend or delete users who break the rules, so that the community remains safe and respectful.  
- As an administrator, I want to oversee all challenges on the platform, so that I can ensure they follow community guidelines.  
- As an administrator, I want to delete inappropriate challenges, so that the platform maintains quality and compliance.  
- As an administrator, I want to manage overall system settings, so that I can maintain the platform's stability and functionality.  
- As an administrator, I want to view platform-wide statistics (total users, active challenges, participation rates), so that I can measure engagement and growth.  
- As an administrator, I want to set password/security policies, so that user accounts are protected.  
- As an administrator, I want to track notification effectiveness, so that I can improve engagement strategies.  
- As an administrator, I want to view a payment history for each user, so that I can maintain financial control.  
- As an administrator, I want the system to generate automatic billing reports, so that I can streamline accounting.  

---

## 2. Data Model

### Entities
- **Users**: People who use the application (role: admin / member).  
- **Challenges**: Challenges created by users.  
- **Challenge_participations**: User enrollment in a challenge (status and accumulated points).  
- **Progress_entries**: Progress logs of participants, with awarded points.  
- **Badges**: Medals defined by the system (gamification).  
- **User_badges**: Association between users and their earned badges.  
- **Categories**: Classification of challenges.  

### Relationships
- A user creates many challenges.  
- A user participates in many challenges through challenge_participations.  
- Each progress_entry belongs to a challenge_participation.  
- Badges are assigned to users through user_badges.  
- A challenge can belong to a category.  

### Rules
- `challenges.start_date <= challenges.end_date`.  
- Email must be unique per user account.  
- Uniqueness constraint between `(user_id, challenge_id)` in challenge_participations.  
- Progress_entries dates must fall between the challenge start and end dates.  
- Leaderboard = sum of `progress_entries.points_awarded`.  

### Entities Diagram:
![diagram](images/diagram.png)
