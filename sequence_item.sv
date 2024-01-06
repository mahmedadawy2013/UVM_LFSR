class sequence_item  extends uvm_sequence_item  ;
/*Register To The Factory Using object utils */
`uvm_object_utils(sequence_item)

/* declaration of the input output signals */
// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
rand  bit                    RST               ;
randc bit [3:0]              SEED              ;
      bit                    OUT               ;
      bit                    Valid             ;

/* declaration of the Constraints for input output signals */
constraint cst {
    SEED > 0 ;
};
function  new(string name = "SEQUENCE_ITEM ");
    super.new(name) ; 
endfunction

/* Function to display the transaction at any time*/

function void display_Sequence_item(input string name = "SEQUENCE ITEM" ); 

    $display ("*************** This is the %0P **********************",name)  ;  
    $display (" SEED       = %0d    RST         =   %0d  ", SEED      , RST      ) ; 
    $display (" OUT        = %0d    Valid       =   %0d  ", OUT       , Valid    ) ; 
    $display ("**********************************************************")   ;
    
endfunction   

endclass
    

	  