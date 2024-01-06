/******************************************************************************
*
* Module: Private - Linear Feedback Shift Register
*
* File Name: LFSR.v
*
* Description:  The LFSR is a shift register that has some of its outputs together in exclusiveOR or
*               exclusive-NOR configurations to form a feedback path The initial content of the shift
*               register is referred to as seed. (Note: any value can be a seed except all O's to avoid
*               lookup state)Lookup state is the state in which shift register values are zeros all the 
*               time while shifting and xoring). - Feedbacks can be comprising of XOR gates or XNOR gates
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//******************** Port Declaration *************************//

module LFSR  (  //Starting the Module and Declaring its name 

input   wire [3:0]          SEED ,
input   wire                RST  ,
input   wire                CLK  ,
output  reg                 OUT  ,
output  reg                 Valid  

);
//********************Internal Signal Declaration*****************//

reg          [3:0]          LFSR     ;
reg          [3:0]          COUNTER1 ;
reg          [3:0]          COUNTER2 ;
wire FeedBack                        ;
wire Bits0_1                         ;
//********************Constant Integer Variables *****************//

integer Loob_variable ;

//*************************The RTL Code***************************//
//********************** Assign Statment *************************//

assign Bits0_1  = ( LFSR[0]^LFSR[1] )  ;
assign FeedBack = ( Bits0_1^LFSR[2] )  ;

//************* Starting The Sequential Always Block *************//

always@(posedge CLK or negedge RST)

begin
  
  if(!RST)
    
    begin 
      
       COUNTER1 <= 0   ;
       COUNTER2 <= 0   ;
    
    end    
    
  else
    
    begin 
      
       
     
      if( COUNTER1 > 7 )
         
         begin 
           
            COUNTER2 <= ( COUNTER2 + 4'b1 ) ;
         
         end
         
         COUNTER1 <= ( COUNTER1 + 4'b1 ) ;

    end    
  
end

//****************************************************************//  

always@(posedge CLK or negedge RST)

begin
  
  if(!RST)
    
    begin 
        
       LFSR  <= SEED ;
       OUT   <= 1'b0 ;
       Valid <= 1'b0 ; 
       
    end   
    
 else if ( COUNTER1 < 4'b1000 ) 
    
    begin 
    
    LFSR[3] <= FeedBack ; 
    for(Loob_variable = 3 ; Loob_variable > 0 ; Loob_variable = Loob_variable -1 )
    LFSR[Loob_variable-1] <= LFSR[Loob_variable];
  
    
    end    
    
 else if ( ( COUNTER1 > 4'b0111 )&&( COUNTER2 < 4'b0100) )   
    
     begin 
    
       OUT  <= LFSR[0];
       LFSR[0] <= LFSR[1];
       LFSR[1] <= LFSR[2];
       LFSR[2] <= LFSR[3];
     Valid <= 1'b1 ;
         
     end   

else     
    
    begin 
        
       OUT   <= 1'b0 ;
       Valid <= 1'b0 ; 
       
    end          
 
 end 
endmodule
