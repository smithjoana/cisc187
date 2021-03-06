.ds LH Postfix Integer Calculator Project
.ds RH CISC-187
.ds CF -%-
.ds CH 
.TL
\*[LH]
.LP
The goal of this project is to create a simple calculator that can perform
arithmetic operations on integers of (practically) unlimited size.

In this project, the calculator must use \fIpostfix\fR notation.
Rather than the functional programming style used in the first two projects,
this project should use object oriented programming techniques.
It should use the \fIChain of Responsibility\fR pattern 
to abstract away the actual operations performed from the calculator class.
The calculator class is merely a simple driver with no knowledge about
the actual calculations performed.
.h1 Turn in Requirements
.LP
All projects will be graded according to the project rubric in BlackBoard.

Before uploading your project, make sure it meets all of the rubric criteria in order to get full credit.
.RS
.nr step 0 1
.IP \n+[step].
Ensure the top of each source file includes your name and student ID.
.IP \n+[step].
Ensure the intent behind every program element is "crystal clear".
Add documentation where it makes sense to do so.
.IP \n+[step].
Ensure all project requirements are met and all results are correct.
.IP \n+[step].
Your finished project should be able to build using \fCmake\fR executed on buffy.
.IP \n+[step].
Use the \fCturnitin\fR script to submit your project files.

Remember to remove any temporary or unwanted files and executables from 
your project before submitting it.
.RE
.h1 Input and Output
.LP
The input to this program should 
.BI
read from standard input
.R 
and the output should be 
.BI
directed to standard output
.R . 

Do \fBNOT\fR put code in your program to open a file by name using a file stream, or file open.
Your program should only read \*[c]std::cin\*[r].

The input stream will consist of a series of arithmetic expressions. 
To simplify the project, all expressions will be in \fIpostfix\fR notation.  
In postfix notation, the operands come before the operator. 
For example, you normally see multiplication written \fCa * b\fR - 
this is referred to as \fIinfix\fR notation. 
In postfix, this expression would appear as \fCa b *\fR. 
For expressions with more than one operator, 
each time an operator is encountered, 
it operates on the two immediately preceding sub-expressions. 
For example, the infix \fCa+b*c\fR would be \fCa b c * +\fR in postfix. 
This means that b and c are multiplied, 
then the results of the multiplication are added to a.
In postfix, there is no operator precedence; 
operators are evaluated left to right. 
Thus, the expression \fC((a + b) * c)\fR is written \fCa b + c *\fR in postfix.  
Postfix eliminates the need for parentheses.
.bp
.h1 Project Requirements
.LP
In order to receive full credit, your project must satisfy \fBall\fR
of the following requirements:
.RS
.nr step 0 1
.IP \n+[step].
Process command line arguments: 
.RS
 \*[c]-h\*[r] to display \*[c]h\*[r]elp text and exit.
 \*[c]-v\*[r] to produce \*[c]v\*[r]erbose output.
.RE
.IP \n+[step].
Process input strings containing equations in postfix notation.
Each equation should reside in a single line of input.
.IP \n+[step].
Process equations using a mix of symbols (addition, multiplication, exponentiation)
containing numbers of arbitrary length

You need to assume that most values will exceed the maximum length for any of
the buitin types in C++.
.IP \n+[step].
Process input interactively in a terminal window.

When running interactively, entering 'quit' exits the program.
.IP \n+[step].
Process input directed into the program from standard input,
for example:
.CW
 # echo "16 16 16 * *" | ./calc -v
 16 16 16 * * = 4096
 #
.R
.br
or
.CW
 # echo "13 55 ^" | ./calc
 18487763498758903017821863604872883745551547783010632046513957
 #
.R
.IP \n+[step].
Process input from a file,
for example given a file input.txt containing:
.CW
 # simple addition
 2 3 +
  
 16 16 16 * *
.R

Then using it should produce:
.CW
 # ./calc -v < input.txt
 2 3 + = 5
 16 16 16 * * = 4096
 #
.R

There is a file of example inputs your calculator should be able to process:
.br
http://209.129.16.61/~dparillo/cisc187/projects/p3-input-examples.txt
.IP \n+[step].
When processing input, the program should silently ignore blank lines
and lines the begin with a \*[c]#\*[r] character.

The program \fBshould\fR be tolerant of leading and trailing whitespace on lines
as well as leading zeroes on values.
.IP \n+[step].
Even if you don't actually use the tests provided in \fC.../projects/p3-test-cases/\fR,
your calculator is still expected to solve the same basic equations
used in those unit tests.
.IP \n+[step].
Encapsulate each operation in a class that inherits from \fCHandler\fR.
Also encapsulate the code to convert strings to numbers in the same way - by extending \fCHandler\fR.

All logic related to performing arithmetic should be confined to classes that extend \fCHandler\fR.
.bp
.IP \n+[step].
Use the provided class to abstract the computation logic.
.CW
 namespace mesa
 { \m[green]
   // An interface to handle arithmetic operations.\m[]
   struct Handler {
     virtual ~Handler() = default; \m[green]
     // Handle a request.
     // @param operands a stack of big integers.
     // @param token evaluated and used during execution.
     //    If the token is not 'appropriate' for this object, 
     //    then do nothing.
     // @return true if this function handled it's token.\m[]
     virtual bool handle(std::stack<mesa::BigInt>& operands, 
                         const std::string& token) const = 0;
   };
 }
.R
.IP \n+[step].
Use a \*[c]std::stack\*[r] to manage calculator operands.
Do not attempt to store operators on the stack.
.RE

.LP
.h2 The Chain of Responsibility Pattern
.LP
The \fIChain of Responsibility design pattern\fR allows an object to handle 
a request without knowing what object will receive and handle it.
Each member in the chain is a link in a linked list data structure.
Objects in the chain are followed until one that can handle the request,
but for this lab, all of the objects that implement the \fCHandler\fR interface
can simply be stored in a \*[c]std::vector\*[r] and iterated over.

All clients of Handler objects treat each object as a 'black box' by simply invoking 
the base object virtual \fChandle()\fR function.

Since the calculator has no idea which Handler will operate on a token, each must be tried.
For example, given the input \fC"2 2 +"\fR,
each part of this string is first split into individual tokens: "2", "2", and "+".
These are stored in a \*[c]std::vector\*[r], which then must be evaluated.

So now we have two \*[c]vector\*[r]'s: 
.RS
.IP 1.
A \*[c]vector\*[r] of \fCConcreteHandler\fR objects:
.RS
\fCAdd\fR, \fCMultiply\fR, \fCPower\fR, and \fCOperandPusher\fR
.RE
.IP 2.
A \*[c]vector\*[r] of \*[c]string\*[r]s
.RE
Each \*[c]string\*[r] will be processed by exactly one \fCConcreteHandler\fR object.
Create an outer loop to loop on each \*[c]string\*[r].
Create an inner loop to loop on each \fCConcreteHandler\fR object.
Call the \fChandle()\fR function of each \fCConcreteHandler\fR object 
and pass in the current \*[c]string\*[r] token as a parameter.
If the current \fCConcreteHandler\fR object knows how to handle the token provided,
then perform it's action.
If the token is an operand, then it is pushed onto the stack provided as a parameter.
If the token is an operator, then two operands are popped off the stack, 
the appropriate operation is performed, 
and the result is pushed back onto the stack.
Once \fChandle\fR returns \*[c]true\*[r], 
processing should continue to the next token.
.h3 References
.RS
.nr step 0 1
.IP \n+[step].
http://www.oodesign.com/chain-of-responsibility-pattern.html
.IP \n+[step].
https://sourcemaking.com/design_patterns/chain_of_responsibility
.RE
.bp
.h1 This is too hard, I need help!!
.LP
If you are having difficulty getting started,
there is a set of unit tests you can use:
.CW
  http://209.129.16.61/~dparillo/cisc187/projects/p3-test-cases/
.R

These tests are in the same style as the lab assignments.
They walk you through getting a working project step by step.
Copy the entire \*[c]p3-test-cases\*[r] directory into the directory
containg your source.
Run the tests like this:
.CW
  make step1
.R

The first step confirms you have the bare minimum source files in your project.
These tests do not test everything,
but do validate the BigInt class and the classes used in the Chain of Responsibility pattern.

These steps are not required to get full credit for this project.

They exist purely for those having trouble getting started.

There are several function tests of the basic arithmetic, however,
which any working calculator should be able to pass.

.h1 Example usage
.LP
This section provides expected outputs from your finished program.
The character \fC#\fR represents the command prompt.
It may look different on your computer.

You are under no compulsion to attempt to replicate these examples exactly.
They do, however, provide reasonable goals, and you are free to emulate
these examples.

Your output should make sense for your application.
.h2 Invoke help
.LP
Provide an \fBaccurate description\fR of how to run the program, then exit.
.CW
  Usage: ./calc [-h] [-v] 
  to run the program interactively. To run using standard input:
	echo 'equation' | ./calc
  where 'equation' is a postfix notation equation, i.e. '2 2 +'
  or:
  	./calc < input_file.txt
  where 'input_file.txt' contains postfix notation equations, one per line

  Options:
    -h   Show this text
    -v   Set a verbose output flag.  Default = false.

  Running with no input from standard in enters 'interactive mode'.
  Equations can be entered one per line.
  The program runs until 'quit' is the first word on a line or EOF is reached.
  #
.R
.h2 Using an input file
.LP
With the verbose output option set:
.CW 
  # ./calc -v < input.txt 
  000000056669777     99999911111 + 352324012 + 03 ^      555557778 * = 562400792227677956625810678708149922000000
  99999999 990001 * 01119111 55565    33333 + * +  88888888              + = 99099674628565
  123456789 1111111111 * 111119 2111111 9111111 * + *  1 ^ = 2638486500477638652325851269760
  9 1 +     5 *     00000000 + = 50
  999999999  0 * = 0
  9 0 ^ = 1
  #
.R
.h2 Interactive mode
.LP
.CW
  # ./calc
  000000056669777     99999911111 + 352324012 + 03 ^      555557778 *
  562400792227677956625810678708149922000000
  1 2 + 3 * 4 ^
  6561
  quit
  #
.R
.h2 Output when bad inputs received
.LP
Under no circumstances should your program throw an unhandled exception, abort, or crash.
A new situation you now need to handle is having too few operators or operands.

The following examples show what handling bad inputs might look like when running interactively.

.CW
  ./calc
  2 +
  Invalid argument: Not enough operands to execute add operation.
  2

  1 2 + + + 
  Invalid argument: Not enough operands to execute add operation.
  Invalid argument: Not enough operands to execute add operation.
  3

  1 2 3 * * * 
  Invalid argument: Not enough operands to execute multiply operation.
  6

  1 2 3 4 * ^
  Error: could not produce a result.
    Too few operators in problem.
    Operands still on problem stack:
    1: 4096
    2: 1
  #
.R

