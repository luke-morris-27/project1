# Luke Morris Devlog for Project 1

# 10-18-2025 9:06 PM
## For this project I am creating a prefix notation expression calculator, which takes user input and stores previous outputs to be reused. I plan on doing some research on such programs in other languages, and learning the paradigms of Haskell better so I can translate it to Haskell. I may write some pseudocode to figure out the functions that will be necessary.

# 10-20-2025 4:09 PM
## To begin this project I need to find what to import so the functions can operate as intended, so I need to research Haskell imports. I also need to take the racket code provided by the professor and make it into Haskell code so I can identify the mode. In this session, I plan to accomplish these two things, as well as get started on a function to take user input.

## End of session update at 4:48 PM: Added imports that should be relevant (getArgs helps read command line args, readMaybe converts strings to numbers, isSpace and isDigit help with checking character types). Added equivalent Haskell code to define interactive. I have accomplished my goal for today to get started on this program and will further develop runCalc next session.

# 10-22-2025 1:39 PM
## For this session, I plan to complete the function that takes the user input, as well work on the function that processes the expressions and operands.

## End of session update at 3:44 PM: Added method to take user input. Started on function to evaluate expression. Have not run into a major problem yet, except that I don't know yet how I will program handling history references in operations, so I might need to do some more research for that. Next session I shall work more on that as well as parsing history references.

# 10-22-2025 9:02 PM
## For this session I am going to create the function that evalutates prefix expressions. I've written some notes and examples on the format of prefix to keep alongside me as I work on this part. I believe recursion may be the best way to implement this method so I can apply it to the next elements after the operand continuously.

## End of session update at 11:30 PM: I have added the function that evaluates prefix expressions using recursion. It defers to two other function to perform the necessary operations depending on what expression it reads. It currently utilizes a yet-to-be-made function that I intend to make to evaluate operands and tokens, like multiplication or addition, in prefix. I added a function to parse references to the history as well, detecting strings that are [$digits]. I need to test this function on a great number of combinations of test inputs to ensure it works correctly. Next I will make the function that evaluates operands.
