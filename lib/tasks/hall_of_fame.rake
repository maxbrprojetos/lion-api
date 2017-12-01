namespace :hall_of_fame do
  task declare_weekly_winner: :environment do
    now = DateTime.now
    abort('Not Monday!') unless now.monday?

    user_id, points = Score.weekly_high_score(now)

    WeeklyWinning.create(
      winner_id: user_id,
      points: points,
      start_date: now.prev_week
    )
  end
end
