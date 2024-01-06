class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
uvm_analysis_imp #(sequence_item,scoreboard) score_mail ; 
int passed_test_cases     ;
int failed_test_cases     ;
static int golden_SEED    ; 
static int golden_FIRST   ; 
static int golden_TWO     ; 
static int golden_THREE   ; 
static int golden_FOUR    ; 
static int bit_counter    ; 

function  new(string name = "SCOREBOARD", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    score_mail = new("score_mail",this) ; 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);

endtask 

task write (sequence_item t_score);
    t_score.display_Sequence_item("SCOREBOARD") ; 
    /**************************************  Reset Test Case ********************************************/
    if (t_score.RST == 0) begin 
        golden_SEED   = t_score.SEED   ;
        golden_FIRST  = golden_SEED[1] ;
        golden_TWO    = golden_SEED[2] ;
        golden_THREE  = golden_SEED[3] ;
        golden_FOUR   = golden_SEED[2] ^ (golden_SEED[1] ^ golden_SEED[0]) ; 
        bit_counter   = 0              ;
        $display("THE golden_FIRST BIT OF OUT IS : %0P ",golden_FIRST) ; 
        $display("THE golden_TWO   BIT OF OUT IS : %0P ",golden_TWO)   ; 
        $display("THE golden_THREE BIT OF OUT IS : %0P ",golden_THREE) ; 
        $display("THE golden_FOUR  BIT OF OUT IS : %0P ",golden_FOUR)  ; 
    end 
    else if (t_score.Valid == 1 && bit_counter == 0  ) begin 
        if (t_score.OUT == golden_FIRST) begin 
            passed_test_cases += 1 ;
        end 
        else  begin
           failed_test_cases += 1  ;
        end
        bit_counter += 1 ; 
    end 
    else if (t_score.Valid == 1 && bit_counter == 1  ) begin 
        if (t_score.OUT == golden_TWO) begin 
            passed_test_cases += 1  ;
        end 
        else  begin
           failed_test_cases += 1  ;
        end
        bit_counter += 1 ; 
    end 
    else if (t_score.Valid == 1 && bit_counter == 2  ) begin 
        if (t_score.OUT == golden_THREE) begin 
            passed_test_cases += 1 ;
        end 
        else  begin
           failed_test_cases += 1  ;
        end
        bit_counter += 1 ; 
    end 
    else if (t_score.Valid == 1 && bit_counter == 3  ) begin 
        if (t_score.OUT == golden_FOUR) begin 
            passed_test_cases += 1 ;
        end 
        else  begin
           failed_test_cases += 1  ;
        end
        bit_counter = 0 ; 
    end 
endtask 

task display_test_cases_report () ;

    $display("The Number of Passed test cases is :%0P " , passed_test_cases ) ; 
    $display("The Number of Failed test cases is :%0P " , failed_test_cases ) ; 
  
endtask 
endclass