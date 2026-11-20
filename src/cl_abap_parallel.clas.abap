CLASS cl_abap_parallel DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES t_task_inst TYPE REF TO if_abap_parallel.
    TYPES t_in_inst_tab TYPE STANDARD TABLE OF t_task_inst WITH EMPTY KEY.
    TYPES:
      BEGIN OF t_out_inst,
        inst    TYPE t_task_inst,
        index   TYPE int4,
        time    TYPE int4,
        message TYPE string,
      END OF t_out_inst.
    TYPES t_out_inst_tab TYPE STANDARD TABLE OF t_out_inst WITH NON-UNIQUE DEFAULT KEY.

    METHODS constructor
      IMPORTING
        p_num_tasks      TYPE i OPTIONAL
        p_timeout        TYPE i OPTIONAL
        p_percentage     TYPE i OPTIONAL
        p_num_processes  TYPE i OPTIONAL
        p_local_server   TYPE abap_bool OPTIONAL
        p_abort_on_error TYPE abap_bool OPTIONAL
        p_keeping_tasks  TYPE abap_bool OPTIONAL.

    METHODS run_inst
      IMPORTING
        p_in_tab  TYPE t_in_inst_tab
        p_debug   TYPE abap_bool OPTIONAL
      EXPORTING
        p_out_tab TYPE t_out_inst_tab.
ENDCLASS.

CLASS cl_abap_parallel IMPLEMENTATION.
  METHOD constructor.
    " the parameters steer work processes, and there are none here: run_inst executes in the current session
    RETURN.
  ENDMETHOD.

  METHOD run_inst.
    DATA lo_inst  TYPE t_task_inst.
    DATA ls_out   TYPE t_out_inst.
    DATA lx_error TYPE REF TO cx_root.

    CLEAR p_out_tab.

    LOOP AT p_in_tab INTO lo_inst.
      CLEAR ls_out.
      ls_out-index = sy-tabix.
      TRY.
          lo_inst->do( ).
          ls_out-inst = lo_inst.
        CATCH cx_root INTO lx_error.
          " a failing task must not take the caller down: its row carries the text and no instance
          ls_out-message = lx_error->get_text( ).
      ENDTRY.
      APPEND ls_out TO p_out_tab.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
