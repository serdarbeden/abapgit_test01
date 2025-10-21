*&---------------------------------------------------------------------*
*& Report YSB_BKPF
*&---------------------------------------------------------------------*
*& Description: BKPF Document Retrieval Report
*& Purpose:     Retrieves and displays accounting documents from BKPF
*& Author:      Refactored for maintainability and error handling
*&---------------------------------------------------------------------*
REPORT ysb_bkpf.

*----------------------------------------------------------------------*
* Type Definitions
*----------------------------------------------------------------------*
TYPES: BEGIN OF ty_bkpf,
         bukrs TYPE bkpf-bukrs,  " Company Code
         belnr TYPE bkpf-belnr,  " Document Number
         gjahr TYPE bkpf-gjahr,  " Fiscal Year
       END OF ty_bkpf.

*----------------------------------------------------------------------*
* Data Declarations
*----------------------------------------------------------------------*
DATA: lt_bkpf TYPE TABLE OF ty_bkpf,
      ls_bkpf TYPE ty_bkpf,
      lv_count TYPE i.

*----------------------------------------------------------------------*
* Selection Screen
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_rows TYPE i DEFAULT 200.  " Number of rows to retrieve
SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* Initialization
*----------------------------------------------------------------------*
INITIALIZATION.
  " Set default text for selection screen title
  TEXT-001 = 'Selection Parameters'.

*----------------------------------------------------------------------*
* Input Validation
*----------------------------------------------------------------------*
AT SELECTION-SCREEN.
  IF p_rows <= 0.
    MESSAGE 'Number of rows must be greater than 0' TYPE 'E'.
  ENDIF.

  IF p_rows > 10000.
    MESSAGE 'Number of rows should not exceed 10000 for performance reasons' TYPE 'W'.
  ENDIF.

*----------------------------------------------------------------------*
* Main Program Logic
*----------------------------------------------------------------------*
START-OF-SELECTION.

  " Retrieve BKPF records
  PERFORM retrieve_bkpf_data.

  " Display results
  PERFORM display_bkpf_data.

*----------------------------------------------------------------------*
* Form  retrieve_bkpf_data
*----------------------------------------------------------------------*
* Retrieve accounting documents from BKPF table
*----------------------------------------------------------------------*
FORM retrieve_bkpf_data.

  SELECT bukrs belnr gjahr
    FROM bkpf
    UP TO @p_rows ROWS
    INTO TABLE @lt_bkpf
    ORDER BY PRIMARY KEY DESCENDING.

  IF sy-subrc <> 0.
    MESSAGE 'No data found in BKPF table' TYPE 'I'.
    RETURN.
  ENDIF.

  lv_count = lines( lt_bkpf ).
  MESSAGE |Retrieved { lv_count } records from BKPF| TYPE 'S'.

ENDFORM.

*----------------------------------------------------------------------*
* Form  display_bkpf_data
*----------------------------------------------------------------------*
* Display retrieved BKPF records with proper formatting
*----------------------------------------------------------------------*
FORM display_bkpf_data.

  CHECK lt_bkpf IS NOT INITIAL.

  " Display header
  WRITE: / sy-uline(60).
  WRITE: / '| Company Code |', 'Document Number      |', 'Fiscal Year |'.
  WRITE: / sy-uline(60).

  " Display data
  LOOP AT lt_bkpf INTO ls_bkpf.
    WRITE: / '|',
              ls_bkpf-bukrs NO-GAP, '           |',
              ls_bkpf-belnr NO-GAP, '|',
              ls_bkpf-gjahr NO-GAP, '       |'.
  ENDLOOP.

  " Display footer
  WRITE: / sy-uline(60).
  WRITE: / |Total records displayed: { lv_count }|.

ENDFORM.

