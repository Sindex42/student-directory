# lets put all the students into an array
students = [
    "Dr. Hannibal Lecter",
    "Darth Vader",
    "Nurse Ratched",
    "Michael Corleone",
    "Alex DeLarge",
    "The Wicked Witch of the West",
    "Terminator",
    "Freddy Krueger",
    "The Joker",
    "Joffrey Baratheon",
    "Norman Bates",
    "Dio Brando"
]


def print_header
  puts "The students of Villains Academy
        -------------"
end

def print(list)
  list.each { |name| puts name }
end

def print_footer(list)
  puts "Overall, we have #{list.length} great students"
end

print_header
print(students)
print_footer(students)
