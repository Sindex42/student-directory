@line_width = 40

@students = []
@student_name = ""
@student_details = []

def input_students_header
  puts "Please enter the names of the students,"
  puts "  followed by any additional details separated by ','"
  puts "To finish, enter 'end' instead of a name\n\n"
end

def input_students_footer
  if @students.length == 1
    puts "Now we have 1 student"
  else
    puts "Now we have #{@students.length} students"
  end
end

def receive_name_input
  puts "Name:"
  @student_name = gets.chomp.capitalize
end

def receive_details_input
  puts "Cohort, Country of Birth, Height(cms):"
  @student_details = gets.chomp.split(",").map!(&:strip)
end

def assign_details
  @students << {
    name: @student_name,
    cohort: @student_details[0].capitalize.to_sym,
    birth_country: @student_details[1].upcase.to_sym,
    height: @student_details[2].to_i
  }
end

def input_students
  input_students_header

  while true do
    receive_name_input()
    break if @student_name == "End"
    receive_details_input()
    assign_details()
    input_students_footer()
  end
end



def print_header
  puts "The students of Villains Academy".center(@line_width)
  puts "-------------".center(@line_width)
end

def print_students_list_loop(students)
  i = 0
  while i < @students.length do
    puts "#{i + 1}. #{@students[i][:name]} (#{@students[i][:cohort]} cohort)"
    i += 1
  end
end

def print_students_list(list)
  list.each_with_index do |student, index|
    puts(
      "#{index + 1}. #{student[:name]} "\
      "(#{student[:cohort]} cohort) "\
      "#{student[:birth_country]} "\
      "#{student[:height]}cms"
      )
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
  if @students.length == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{students.length} great students"
  end
end


input_students
print_header
print_students_list(@students)
#print_by_letter(@students)
#print_by_length(@students)
print_footer(@students)
