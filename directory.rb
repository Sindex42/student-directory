@students = []
@cohort_list = []
@longest_name = 0
@line_width = 40

## methods
# input methods
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

  # input sub methods
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


# print methods
def print_header
  puts "The students of Villains Academy".center(@line_width)
  puts "-------------".center(@line_width)
  print "Nr Name"
  add_name_spacing(-2)
  puts "Cohort           Country Height"
end

def print_students_list(students)
  students.each_with_index do |student, student_number|
    print "#{student_number + 1}. #{student[:name]}"
    add_name_spacing(1, student[:name].length)
    puts(
      "(#{student[:cohort]} cohort) "\
      "#{student[:birth_country]} "\
      "#{student[:height].to_i}cms"
      )
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
  puts ""
end

  # print sub-methods
  def add_name_spacing(shift = 0, category = 0)
    (@longest_name - category + shift).times { print " " }
  end

  def list_all_cohorts
    @cohort_list = (@students.map { |student| student[:cohort] }).uniq
  end

  # alternate print methods
  def print_students_list_loop(students)
    i = 0
    while i < @students.length do
      puts "#{i + 1}. #{@students[i][:name]} (#{@students[i][:cohort]} cohort)"
      i += 1
    end
  end

  def print_students_by_letter(students, letter)
    students.each_with_index do |student, index|
      if student[:name].start_with?(letter)
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  end

  def print_students_by_length(students, length)
    list.each_with_index do |student, index|
      if student[:name].length <= length
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  end

  def print_students_by_cohort(students)
    list_all_cohorts()
    @cohort_list.each do |cohort|
      students.each_with_index do |student, student_number|
        if student[:cohort] == cohort
          print "#{student_number + 1}. #{student[:name]}"
          add_name_spacing(1, student[:name].length)
          puts(
            "(#{student[:cohort]} cohort) "\
            "#{student[:birth_country]} "\
            "#{student[:height].to_i}cms"
            )
        end
      end
    end
  end


# interactive menu
def interactive_menu
  loop do
    print_menu()
    process(gets.chomp)
  end
end

  # menu sub-methods
  def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "9. Exit"
  end

  def show_students
    unless @students.empty?
      print_header()
      print_students_list(@students)
      #print_students_by_cohort(@students)
    end
    print_footer(@students)
  end

  def process(selection)
    case selection
    when "1"
      input_students()
    when "2"
      show_students()
    when "3"
      save_students()
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end

  def save_students
    # open the file for writing
    file = File.open("students.csv", "w")
    # iterate over the array of students
    @students.each do |student|
      student_data = [
        student[:name],
        student[:cohort],
        student[:birth_country],
        student[:height]
      ]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    file.close
  end

## program instructions
interactive_menu()
