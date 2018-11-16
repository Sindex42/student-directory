@students = []
@longest_name = 0
@line_width = 40

  def input_students_header
    puts "Please enter the names of the students,"\
         " followed by any prompted additional details"
    puts "To exit, enter a 'blank' name\n\n"
  end

  def receive_name_input
    puts "Name:"
    #@student_name = gets.chomp
    # reformats names so that every word is capitalized
    @student_name = gets.chomp.split.map(&:capitalize).join(" ")
  end

  def update_longest_name
    @longest_name = @student_name.length if @student_name.length > @longest_name
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
    puts ""
  end

def input_students
    input_students_header

    while true do
      receive_name_input()
      break if @student_name.empty?
      update_longest_name()
      receive_details_input()
      assign_details()
      input_students_footer()
    end
end


def print_header
  puts "The students of Villains Academy".center(@line_width)
  puts "-------------".center(@line_width)
  print "Nr Name"
  # whitespace pading for "Cohort"
  (@longest_name - 2).times { print " " }
  puts "Cohort           Country Height"
end

def print_students_list(students)
  students.each_with_index do |student, student_number|
    print "#{student_number + 1}. #{student[:name]}"
    # whitespace padding
    (@longest_name - student[:name].length + 1).times { print " " }
    puts(
      "(#{student[:cohort]} cohort) "\
      "#{student[:birth_country]} "\
      "#{student[:height].to_i}cms"
      )
  end
end

  def print_students_list_loop(students)
    i = 0
    while i < @students.length do
      puts "#{i + 1}. #{@students[i][:name]} (#{@students[i][:cohort]} cohort)"
      i += 1
    end
  end

  def print_students_by_letter(students)
    students.each_with_index do |student, index|
      if student[:name].start_with?("D")
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  end

  def print_students_by_length(students)
    list.each_with_index do |student, index|
      if student[:name].length <= 12
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  end

  def print_students_by_cohort(students)

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
