namespace :hall_of_fame do
  task declare_weekly_winner: :environment do
    now = DateTime.now
    abort('Not Monday!') unless now.monday?

    week = now.prev_week
    user_id, points = Score.weekly_high_score(week)

    WeeklyWinning.create(
      winner_id: user_id,
      points: points,
      start_date: week
    )
  end
end
