class reset_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
int last_SEED ; 
`uvm_object_utils(reset_sequence)
/*Create an instance from the sequence item to be the transaction data*/
sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      start_item(t)                          ;
        t.randomize() with {t.RST  == 0 ; }  ; 
        last_SEED = t.SEED ; 
        t.display_Sequence_item("SEQUENCE")  ;
      finish_item(t)                         ; 
      start_item(t)                          ;
        t.randomize() with {t.RST  == 1 ;
                            t.SEED == last_SEED ;}   ; 
        t.display_Sequence_item("SEQUENCE")  ;
      finish_item(t)                         ; 
endtask

endclass

