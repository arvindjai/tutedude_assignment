'''
2 Student Grades
Create a dictionary where the keys are student names and the values are their grades. Allow the user to:
Add a new student and grade.
Update an existing student’s grade.
Print all student grades.
Used dictionary and basic operations. Using if else:
'''

student_grades = {
    "Rohan" : 75,
    "Arun" : 66,
    "Vijay" : 90
}

def add_students():
    name = input("Enter student name: ")
    if name in student_grades:
        print(f"{name} already exists with grade {student_grades[name]}.")
    else:
        grade = input("Enter grade for the student: ")
        student_grades[name] = grade
        print(f"{name} added successfully.")
    
def update_grade():
    name = input("Enter student name to update grade: ")
    if name in student_grades:
        new_grade = input("Enter new grade: ")
        student_grades[name] = new_grade
        print(f"{name}'s grade update to {new_grade}")
    else:
        print(f"{name} does not exists.")

def print_all_grades():
    # if not student_grades:
    #     print("No sudents in the list.")
    print("All Students Grades: ")
    for name, grade in student_grades.items():
        print(f"{name}: {grade}")

def main():
    while True:
        print("\n========== Student Grade Manager ===============")
        print("1. Add new student and grade")
        print("2. Update existing student's grade")
        print("3. Print all students and grades")
        print("4. Exit")

        choice = input("Enter your choice (1-4): ")

        if choice == '1':
            add_students()
        elif choice == '2':
            update_grade()
        elif choice == '3':
            print_all_grades()
        elif choice == '4':
            print("Exiting program. Goodbye!")
            break
        else:
            print("Invalid choice. Please try again.")

main()