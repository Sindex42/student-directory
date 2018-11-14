# lets put all the students into an array
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.length} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy
        -------------"
end

def print(list)
  list.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_by_letter(list)
  list.each_with_index do |student, index|
    if student[:name].start_with?("D")
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_by_length(list)
  list.each_with_index do |student, index|
    if student[:name].length <= 12
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(list)
  puts "Overall, we have #{list.length} great students"
end

students = input_students
print_header
print(students)
#print_by_letter(students)
#print_by_length(students)
print_footer(students)
