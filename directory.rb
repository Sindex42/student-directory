require "csv"

@students = []
@cohort_list = []
@longest_name = 0
@line_width = 40
@filename = ""
@letter = ""

## methods
# input methods
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


  # input sub methods
  def input_students_header
    puts "Please enter the names of the students,"\
         " followed by any prompted additional details"
    puts "To exit, enter a 'blank' name\n\n"
  end

  def receive_name_input
    puts "Name:"
    @student_name = STDIN.gets.chomp.split.map(&:capitalize).join(" ")
  end

  def receive_details_input
    puts "Cohort:"
    @cohort = STDIN.gets.chomp
    @cohort = "november" if @cohort.empty?
    puts "Country of Birth:"
    @country = STDIN.gets.chomp
    @country = "unknown" if @country.empty?
    puts "Height(cms):"
    @height = STDIN.gets.chomp
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

def set_longest_name
  @students.each do |student|
    if student[:name].length > @longest_name
      @longest_name = student[:name].length
    end
  end
end

def print_students_list(students)
  students.each_with_index do |student, student_number|
    print_one_student(student, student_number)
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
  def print_one_student(student, student_number)
    print "#{student_number + 1}. #{student[:name]}"
    add_name_spacing(1, student[:name].length)
    puts(
      "(#{student[:cohort]} cohort) "\
      "#{student[:birth_country]} "\
      "#{student[:height].to_i}cms"
        )
  end

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

  def print_students_by_letter(students)
    students.each_with_index do |student, student_number|
      if student[:name].start_with?(@letter)
        print_one_student(student, student_number)
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
          print_one_student(student, student_number)
        end
      end
    end
  end




# interactive menu
def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil?
  if File.exists?(filename) # if it exists
    load_students(filename)
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def interactive_menu
  loop do
    print_menu()
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show students in numerical order"
  puts "3. Show students grouped by cohort"
  puts "4. Show students whose name begins with ..."
  puts "6. Save the list to a file"
  puts "7. Load the list from a file"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students()
  when "2"
    show_students()
  when "3"
    show_students_by_cohort()
  when "4"
    choose_letter()
    show_students_by_letter()
  when "6"
    puts "Save as? (leave blank if saving as students.csv)"
    choose_file()
    save_students()
  when "7"
    puts "Enter file to load (leave blank if loading students.csv)"
    choose_file()
    @students = []
    load_students(@filename)
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end


  # menu options
  def show_students
    unless @students.empty?
      set_longest_name()
      print_header()
      print_students_list(@students)
    end
    print_footer(@students)
  end

  def show_students_by_cohort
    unless @students.empty?
      set_longest_name()
      print_header()
      print_students_by_cohort(@students)
    end
    print_footer(@students)
  end

  def show_students_by_letter
    unless @students.empty?
      set_longest_name()
      print_header()
      print_students_by_letter(@students)
    end
    print_footer(@students)
  end

  def save_students
    # open the file for writing
    CSV.open(@filename, "w") do |file|
      @students.each do |student|
        student_data = [
          student[:name],
          student[:cohort],
          student[:birth_country],
          student[:height]
        ]
        file << student_data
      end
    end
    puts "Saved #{@students.length} students to #{@filename}\n\n"
  end

  def load_students(filename)
    CSV.foreach(filename) do |line|
      @student_name, @cohort, @country, @height = line
        assign_details()
    end
    puts "Loaded #{@students.count} students from #{filename}\n\n"
  end


  # menu sub-methods
  def choose_file
    @filename = STDIN.gets.chomp
    @filename = "students.csv" if @filename.empty?
  end

  def choose_letter
    puts "Enter the first letter of the names you wish to show"
    @letter = STDIN.gets.chomp.capitalize
  end


## program instructions
try_load_students()
interactive_menu()
