def get_rules(file)
  file[0].split("\n").map { _1.split("|").map(&:to_i) }
end

def get_updates(file)
  file[1].split("\n").map { _1.split(",").map(&:to_i) }
end

def invalid_updates(updates, rules)
  updates.map do |update|
    update_validation = update.map.with_index do |page, index|
      next_pages = update[index+1..]
      page_rules = rules.select {|rule| rule[0] == page }
      next_pages.map do |n_page|
        true if page_rules.find {|rule| rule == [page, n_page] }
      end
    end.flatten
    update if update_validation.any?(nil)
  end.compact
end

def sum_middle_pages(updates)
  updates.map do |update|
    middle_index = (update.length/2)
    update[middle_index]
  end.sum
end

def valid_update?(update, rules)
  update.map.with_index do |page, index|
    next_pages = update[index+1..]
    page_rules = rules.select {|rule| rule[0] == page }
    next_pages.map do |n_page|
      true if page_rules.find {|rule| rule == [page, n_page] }
    end
  end.flatten.all?
end

file = File.read("input_day_5.txt").split("\n\n")
rules = get_rules(file)
updates = get_updates(file)

invalid_updates = invalid_updates(updates, rules)

invalid_updates.map do |update|
  update.map.with_index do |page, index|
    next_pages = update[index+1..]
    page_rules = rules.select {|rule| rule[0] == page }
    next_pages.map do |n_page|
      if !page_rules.find {|rule| rule == [page, n_page] }
        if rules.find {|rule| rule == [n_page, page] }
          page_index = update.index(page)
          n_page_index = update.index(n_page)
          update[page_index], update[n_page_index] = update[n_page_index], update[page_index]
        end
      end
    end
  end
  if !valid_update?(update, rules)
    redo
  end
end 

puts sum_middle_pages(invalid_updates)
