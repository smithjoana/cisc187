#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include "../Multiply.h"
#include "../BigInt.h"
#include <doctest.h>
#include <stack>
#include <stdexcept>

using mesa::Multiply;
using mesa::BigInt;
using std::stack;

//
// For these tests to compile implement:
//  - mesa::Multiply
//

SCENARIO ("test ability to skip non-multiply command input") {
  std::stack<BigInt> actual;
  Multiply handler;
  bool response = true;
  GIVEN ("an empty stack") {
    WHEN ("the token is '2'") {
      response = handler.handle(actual, "2");
      THEN ("the stack should remain empty") {
        REQUIRE (actual.empty());
      }
      AND_THEN ("handle should return false") {
        REQUIRE (response == false);
      }
    }

    WHEN ("the token is '+'") {
      response = handler.handle(actual, "+");
      THEN ("the stack should remain empty") {
        REQUIRE (actual.empty());
      }
      AND_THEN ("handle should return false") {
        REQUIRE (response == false);
      }
    }

    WHEN ("the token is '^'") {
      response = handler.handle(actual, "^");
      THEN ("the stack should remain empty") {
        REQUIRE (actual.empty());
      }
      AND_THEN ("handle should return false") {
        REQUIRE (response == false);
      }
    }

    WHEN ("the token is '!'") {
      response = handler.handle(actual, "!");
      THEN ("the stack should remain empty") {
        REQUIRE (actual.empty());
      }
      AND_THEN ("handle should return false") {
        REQUIRE (response == false);
      }
    }
  }
}



SCENARIO ("test ability to process multiplication commands") {
  std::stack<BigInt> actual;
  Multiply handler;
  bool response = false;
  GIVEN ("a stack with operands: 2, 3") {
    actual.push(BigInt{2});
    actual.push(BigInt{3});
    WHEN ("the token is '*'") {
      response = handler.handle(actual, "*");
      THEN ("the stack should multiply them and push the result onto the stack: BigInt{6}") {
        REQUIRE (!actual.empty());
        REQUIRE (operator==(actual.top(), BigInt{6}));
      }
      AND_THEN ("handle should return true") {
        REQUIRE (response);
      }
    }
  }

  GIVEN ("a stack with operands: 1, 2, 3, 4") {
    WHEN ("the multiply handler is invoked") {
      actual.push(BigInt{1});
      actual.push(BigInt{2});
      actual.push(BigInt{3});
      actual.push(BigInt{4});
      response = handler.handle(actual, "*");
      THEN ("the handler should multiply the two top elements and push the result onto the stack") {
        REQUIRE (operator==(actual.top(), BigInt{12}));
      }
      AND_THEN ("the stack should contain 3 elements") {
        REQUIRE (actual.size() == 3);
      }
      AND_THEN ("handle should return true") {
        REQUIRE (response);
      }
    }
  }

  GIVEN ("a stack with one operand") {
    WHEN ("the multiply handler is invoked") {
      actual.push(BigInt{1});
      
      THEN ("the handler should throw an invalid_argument exception") {
        CHECK_THROWS_AS(handler.handle(actual, "*"), std::invalid_argument);
      }
    }
  }

  GIVEN ("an empty stack") {
    WHEN ("the multiply handler is invoked") {
      THEN ("the handler should throw an invalid_argument exception") {
        CHECK_THROWS_AS(handler.handle(actual, "*"), std::invalid_argument);
      }
    }
  }
}



