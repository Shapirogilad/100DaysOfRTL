// Simple edge detector TB

module Detector_tb ();

  logic clk;
  logic reset;
  
  logic a_i;
  
  logic rising_edge_o;
  logic falling_edge_o;
  
    Detector Detector1(
    .clk(clk),
    .reset(reset),
    .a_i(a_i),
    .rising_edge_o(rising_edge_o),
    .falling_edge_o(falling_edge_o)
  );

  //Generate clk
  always begin
    clk = 1'b1;
    #5; //wait 5 time units
    clk = 1'b0;
    #5;
  end
  
  //Start testing
  initial begin
    reset <= 1'b1;
    a_i <= 1'b1;
    @(posedge clk); //waiting for the clk to rise
    
    reset <= 1'b0;
    @(posedge clk);
    
    for(int i = 0; i<32; i++) begin
      a_i <= $random % 2;
      @(posedge clk);
    end
    $finish();
  end
endmodule
