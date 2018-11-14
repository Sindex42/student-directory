# lets put all the students into an array
def input_students
  puts "Please enter the names of the students,"
  puts "  followed by additional details separated by ','"
  puts "To finish, enter 'end'\n\n"
  # create an empty array
  students = []
  # while the name is not empty, repeat this code
  while true do
    puts "Name:"
    name = gets.chomp.capitalize
    break if name == "End"

    puts "Cohort, Country of Birth, Height(cms):"
    details = gets.chomp.split(",").map!(&:strip)
    #details.map! { |category| category.strip }

    # add the student hash to the array
    students << {
      name: name,
      cohort: details[0].capitalize.to_sym,
      birth_country: details[1].upcase.to_sym,
      height: details[2].to_i
    }
    puts students
    puts "Now we have #{students.length} students"
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy
        -------------"
end

def print_students_list_loop(students)
  i = 0
  while i < students.length do
    puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)"
    i += 1
  end
end

def print_students_list(list)
  list.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_by_letter(students)
  list.each_with_index do |student, index|
    if student[:name].start_with?("D")
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_by_length(students)
  list.each_with_index do |student, index|
    if student[:name].length <= 12
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.length} great students"
end

students = input_students
print_header
print_students_list(students)
#print_by_letter(students)
#print_by_length(students)
print_footer(students)
