module Detector (
  input     wire    clk,
  input     wire    reset,

  input     wire    a_i,

  output    wire    rising_edge_o,
  output    wire    falling_edge_o
);

 reg previous_a;
  
  always@(posedge clk or posedge reset) begin
    if(reset)
      previous_a <= 1'b0;
    else
      previous_a <= a_i;  
  end
 
  //Rising edge when previous_a = 0 AND a_i = 1
  assign rising_edge_o = ~previous_a & a_i;
  
  //falling edge when previous_a = 1 AND a_i = 0
  assign falling_edge_o = previous_a & ~a_i;
      
endmodule