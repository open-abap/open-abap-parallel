CLASS cl_abap_parallel DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES ty_in_tab TYPE STANDARD TABLE OF REF TO if_abap_parallel WITH DEFAULT KEY.

    METHODS constructor
      IMPORTING
        p_num_tasks  TYPE i OPTIONAL
        p_percentage TYPE i OPTIONAL
        p_local_mode TYPE abap_bool OPTIONAL
        p_timeout    TYPE i OPTIONAL.

    METHODS run_inst
      IMPORTING
        p_in_tab  TYPE ty_in_tab
      EXPORTING
        p_out_tab TYPE ty_in_tab.
ENDCLASS.

CLASS cl_abap_parallel IMPLEMENTATION.
  METHOD constructor.
    " todo, implement method
    RETURN.
  ENDMETHOD.

  METHOD run_inst.
    " todo, implement method
    RETURN.
  ENDMETHOD.
ENDCLASS.
