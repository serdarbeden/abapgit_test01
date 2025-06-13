*&---------------------------------------------------------------------*
*& Report YSB_BKPF
*&---------------------------------------------------------------------*
*& Retrieves last 200 records from BKPF
*&---------------------------------------------------------------------*
REPORT ysb_bkpf.

TABLES: bkpf.

DATA: lt_bkpf TYPE TABLE OF bkpf,
      ls_bkpf TYPE bkpf.

SELECT bukrs belnr gjahr
  FROM bkpf
  UP TO 200 ROWS
  INTO TABLE lt_bkpf
  ORDER BY PRIMARY KEY DESCENDING.

LOOP AT lt_bkpf INTO ls_bkpf.
  WRITE: / ls_bkpf-bukrs, ls_bkpf-belnr, ls_bkpf-gjahr.
ENDLOOP.

