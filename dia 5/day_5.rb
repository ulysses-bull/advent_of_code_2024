def get_rules(file)
  file[0].split("\n").map { _1.split("|").map(&:to_i) }
end

def get_updates(file)
  file[1].split("\n").map { _1.split(",").map(&:to_i) }
end

def valid_updates(updates, rules)
  updates.map do |update|
    update_validation = update.map.with_index do |page, index|
      next_pages = update[index+1..]
      page_rules = rules.select {|rule| rule[0] == page }
      next_pages.map do |n_page|
        true if page_rules.find {|rule| rule == [page, n_page] }
      end
    end.flatten
    update if update_validation.all?
  end.compact
end

def sum_middle_pages(updates)
  updates.map do |update|
    middle_index = (update.length/2)
    update[middle_index]
  end.sum
end

file = File.read("input_day_5.txt").split("\n\n")
rules = get_rules(file)
updates = get_updates(file)

valid_updates = valid_updates(updates, rules)
puts sum_middle_pages(valid_updates)
