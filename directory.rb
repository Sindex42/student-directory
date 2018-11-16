@line_width = 40
#@longest_name = 0

@students = []

def input_students_header
  puts "Please enter the names of the students,"\
       " followed by any prompted additional details\n\n"
end

def receive_name_input
  puts "Name:"
  @student_name = gets.chomp.capitalize
end

def receive_details_input
  puts "Cohort:"
  @cohort = gets.chomp
  @cohort = "november" if @cohort.empty?
  puts "Country of Birth:"
  @country = gets.chomp
  @country = "unknown" if @country.empty?
  puts "Height(cms):"
  @height = gets.chomp
  @height = "unknown" if @height.empty?
end

def assign_details
  @students << {
    name: @student_name,
    cohort: @cohort.capitalize.to_sym,
    birth_country: @country.upcase.to_sym,
    height: @height
  }
end

def input_students_footer
  if @students.length == 1
    puts "Now we have 1 student"
  else
    puts "Now we have #{@students.length} students"
  end
end

  def input_students
    input_students_header

    while true do
      receive_name_input()
      break if @student_name.empty?
      receive_details_input()
      assign_details()
      input_students_footer()
    end
  end

def skip_print?
end

def print_header
  puts "The students of Villains Academy".center(@line_width)
  puts "-------------".center(@line_width)
  puts "   Name    Cohort    Country    Height"
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
      "#{student[:height].to_i}cms"
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
  case @students.length
  when 0
    puts "We have no students"
  when 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{students.length} great students"
  end
end


input_students()

unless @students.empty?
  print_header()
  print_students_list(@students)
end

print_footer(@students)
