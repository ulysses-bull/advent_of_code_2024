def increasing?(report)
  0.upto(report.length - 2) do |level|
    current_number = report[level]
    next_number = report[level + 1]
    return false if next_number < current_number
  end
  true
end

def decreasing?(report)
  0.upto(report.length - 2) do |level|
    current_number = report[level]
    next_number = report[level + 1]
    return false if next_number > current_number
  end
  true
end

def valid_difference?(report)
  0.upto(report.length - 2) do |level|
    current_number = report[level]
    next_number = report[level + 1]
    difference = (current_number - next_number).abs
    return false if difference < 1 || difference > 3
  end
  true
end

# file = File.read("sample_2.txt").split("\n")
file = File.read("input_day_2.txt").split("\n")
reports = file.map { _1.split(" ").map(&:to_i) }

reports_analyze = reports.map do |report|
  if (increasing?(report) || decreasing?(report)) && valid_difference?(report)
    true
  else
    report.map.with_index do |level, index|
      new_report = report.reject.with_index{|v, i| i == index }
      (increasing?(new_report) || decreasing?(new_report)) && valid_difference?(new_report)
    end.any?
  end
end

puts reports_analyze.count(true)
