module tb ()  ;

    import uvm_pkg::*   ;  
    import pack1::*     ;
    intf intf1()        ; 
       

    LFSR LFSR_INSTANCE (
        .CLK   (intf1.CLK   ) ,
        .RST   (intf1.RST   ) ,
        .SEED  (intf1.SEED  ) ,
        .OUT   (intf1.OUT   ) ,
        .Valid (intf1.Valid ) 
    ); 

    initial begin 
        intf1.CLK = 1 ; 
    end  

    always  begin
       #5 intf1.CLK= ~ intf1.CLK; 
    end

    initial begin
        uvm_config_db #(virtual intf)::set(null,"*","my_vif",intf1) ; 
        run_test("test") ; 
    end 
endmodule