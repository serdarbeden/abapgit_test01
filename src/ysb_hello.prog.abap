*&---------------------------------------------------------------------*
*& Report YSB_HELLO
*&---------------------------------------------------------------------*
*& Description: Greeting Program
*& Purpose:     Displays greeting messages
*& Author:      Refactored for maintainability
*&---------------------------------------------------------------------*
REPORT ysb_hello.

* Constants for greetings
CONSTANTS:
  BEGIN OF gc_greetings,
    git    TYPE string VALUE 'Hello Git',
    world  TYPE string VALUE 'Hello World',
    serdar TYPE string VALUE 'Hello Serdar',
  END OF gc_greetings.

*----------------------------------------------------------------------*
* Main Program Logic
*----------------------------------------------------------------------*
START-OF-SELECTION.

  " Display greetings in a structured manner
  PERFORM display_greetings.

*----------------------------------------------------------------------*
* Form  display_greetings
*----------------------------------------------------------------------*
* Display all greeting messages
*----------------------------------------------------------------------*
FORM display_greetings.

  WRITE: / gc_greetings-git.
  WRITE: / gc_greetings-world.
  WRITE: / gc_greetings-serdar.

ENDFORM.
