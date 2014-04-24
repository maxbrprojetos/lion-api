namespace :hall_of_fame do
  task declare_weekly_winner: :environment do
    abort('Not Monday!') unless Time.now.wday == 1

    top_score = Score.top_weekly

    if WeeklyWinning.create(winner: top_score.user, points: top_score.points, start_date: 1.day.ago.beginning_of_week)
      Score.weekly.reset_points
    end
  end
end
