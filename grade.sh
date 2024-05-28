set -e
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
# Check if correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: bash grade.sh <github_repo_url>"
    exit 1
fi

# Clone the student's repository
git clone "$1" student_repo

# Check if the required file ListExamples.java exists
if [ ! -f "student_repo/ListExamples.java" ]; then
    echo "Error: ListExamples.java not found in the repository."
    exit 1
fi

# Move to the grading area
cd student_repo

# Compile the student's code
javac ListExamples.java

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed."
    exit 1
fi

# Move to the parent directory
cd ..

# Compile the test file (Assuming it's named TestListExamples.java)
javac -cp junit-4.13.2.jar:. TestListExamples.java

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Error: Test file compilation failed."
    exit 1
fi

# Run the tests
java -cp junit-4.13.2.jar:hamcrest-core-1.3.jar:. org.junit.runner.JUnitCore TestListExamples


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
