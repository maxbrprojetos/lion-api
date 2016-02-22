task recalculate_points: :environment do
  RecalculatePoints.perform_async
end
