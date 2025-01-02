file = File.read("input_day_5.txt").split("\n\n")
rules = file[0].split("\n").map { _1.split("|").map(&:to_i) }
updates = file[1].split("\n").map { _1.split(",").map(&:to_i) }

middle_pages = updates.map do |update|
  update_validation = update.map.with_index do |page, index|
    valid_page = true
    next_pages = update[index+1..]
    page_rules = rules.select {|rule| rule[0] == page }
    validations = next_pages.map do |n_page|
      if rules.find {|rule| rule == [page, n_page] }
        true
      else
        false
      end
    end
    validations
  end.flatten
  if update_validation.all?
    middle_index = (update.length/2)
    update[middle_index]
  end
end.compact

puts middle_pages.sum
