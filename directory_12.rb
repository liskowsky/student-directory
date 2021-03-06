$months = ['January', 'February', 'March',
          'April', 'May', 'June', 'July',
          'August', 'September', 'October',
          'November', 'December']
$line_length = 40
@students = []

def input_students
  name = 'NONAME'
  default = 'July'
  until name.empty?
    puts 'Please enter the name of the student'
    name = gets.chomp.capitalize
    break if name.empty?
    puts 'Please enter your cohort (using full month)'
    cohort = gets.chomp.capitalize
    puts 'Please enter your hobbies'
    hobbies = gets.chomp.capitalize
    puts 'Please enter your country of birth'
    country = gets.chomp.capitalize
    puts 'Please enter your height'
    height = gets.delete("\n") #insted of chomp
    if cohort.empty? or !$months.include?(cohort)
      cohort = default
    end
    puts 'To finish, just hit return twice'
    @students << {name: name, cohort: cohort, hobbies: hobbies, country: country, height: height}
    puts "Now we have #{@students.count} #{@students.count == 1? "student" : "students"}"
  end
    @students
end

def print_header
  puts 'The students of my cohort at Makers Academy'
  puts '-------------------------------------------'
end

def print_students(students)
  if !@students.empty?
    @students.each do |student|
      student.each do |key, value|
          puts key.to_s.rjust($line_length/2) + ":" + value.to_s.ljust($line_length/2)
      end
      puts
    end
  else
    puts "NOTHIG TO PRINT"
  end
end

def print_by_cohort(students)
    cohort_month = []
    puts "See by specific cohort month? - Enter Full Month Please"
    month = gets.chomp.capitalize
      @students.map do |student|
        if student[:cohort] == month
          cohort_month << student
      end
    end
    print_students(cohort_month)
  end

def print_footer(names)
    if names.length < 1
      puts "There are no students at present"
    else
      puts "Overall, we have #{names.count} #{names.count == 1? "student" : "students"}"
    end
end

def print_menu
  puts "What you want to do."
  puts "1. Add students"
  puts "2. Show students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students(@students)
  print_footer(@students)
end

def save_students
  file = File.open("students.csv","w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobbies], student[:country], student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort, hobbies, country, height = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, country: country, height: height}
  end
  file.close
end

def process(selection)
  case selection
  when "1"
    students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "Wrong input. Try again."
  end
end

def user_input
  loop do
    print_menu
    process(gets.chomp)
  end
end

user_input
