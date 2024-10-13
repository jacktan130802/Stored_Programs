import csv
import random

# Load the student records from CSV
def load_students_from_csv(csv_file_path):
    with open(csv_file_path, mode='r', newline='') as file:
        reader = csv.DictReader(file)
        students = [row for row in reader]
    return students

# Shuffle the students in the records
def shuffle_students(records):
    random.shuffle(records)
    return records

def can_add_to_team(student, team, school_count, gender_count):
    """ Check if the student can be added to the team based on diversity criteria. """
    # Check school affiliation
    if school_count.get(student['School'], 0) >= 2:
        return False  # Too many from the same school

    # Check gender
    if gender_count[student['Gender']] >= 3:
        return False  # Too many from the same gender

    return True

def form_diverse_teams(student_records):
    """ Form diverse teams based on given criteria. """
    teams = []
    shuffled_students = shuffle_students(student_records)  # Shuffle to randomize order

    while len(shuffled_students) >= 5:
        team = []
        school_count = {}
        gender_count = {'Male': 0, 'Female': 0}
        total_cgpa = 0

        for student in shuffled_students:
            # Check if adding this student maintains diversity
            if can_add_to_team(student, team, school_count, gender_count):
                team.append(student)
                total_cgpa += float(student['CGPA'])
                # Update counts
                school_count[student['School']] = school_count.get(student['School'], 0) + 1
                gender_count[student['Gender']] += 1

            # Check if the team is complete
            if len(team) == 5:
                break
        
        # If a complete team is formed, add to teams and remove from shuffled list
        if len(team) == 5:
            teams.append(team)
            shuffled_students = [s for s in shuffled_students if s not in team]

    return teams

# Save the assigned teams to a new CSV file
def save_teams_to_csv(teams, output_csv_path):
    with open(output_csv_path, mode='w', newline='') as file:
        fieldnames = ['Tutorial Group', 'Student ID', 'School', 'Name', 'Gender', 'CGPA', 'Team Assigned']
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        
        for i, team in enumerate(teams):
            for student in team:
                student['Team Assigned'] = i + 1  # Assign team number
                writer.writerow(student)

# Execute the team formation
input_csv_path = '/mnt/data/records(1).csv'  # Path to your input CSV file
output_csv_path = '/mnt/data/assigned_teams.csv'  # Path to your output CSV file

student_records = load_students_from_csv(input_csv_path)
teams = form_diverse_teams(student_records)
save_teams_to_csv(teams, output_csv_path)

print("Teams have been formed and saved to 'assigned_teams.csv'.")
