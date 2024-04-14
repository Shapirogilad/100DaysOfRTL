// Simple edge detector TB

module Detector_tb ();

  // Comparison Function Definition
  function automatic Compare_values(string msg, logic exp, logic act);
    begin
      // Perform Comparison
      if(exp != act) begin
        $display("Error in %s Exp 0x%h Act 0x%h",msg, exp, act);
        return 1;
      end
      return 0;
    end
  endfunction

  function automatic Test_check(logic flag1, logic flag2, int num_test);
    begin
      if(!flag1 & !flag2) begin
        $display("Test %0d passed!", num_test);
      end
    end
  endfunction
  
  
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

  logic previous_a;
  logic exp_rising;
  logic exp_falling;

  logic flag1;
  logic flag2;

  //Generate clk
  always begin
    clk = 1'b1;
    #5; //wait 5 time units
    clk = 1'b0;
    #5;
  end
  
  assign exp_rising = reset ? 1'b0 : (~previous_a & a_i);
  assign exp_falling = reset ? 1'b0 : (previous_a & ~a_i);

  //Start testing
  initial begin
    reset <= 1'b1;
    a_i <= 1'b1;
    @(posedge clk); //waiting for the clk to rise
    previous_a <= a_i;
    flag1 = Compare_values("rising edge", exp_rising, rising_edge_o);
    flag2 = Compare_values("falling edge", exp_falling, falling_edge_o);
    Test_check(flag1, flag2, 1);

    reset <= 1'b0;
    @(posedge clk);
    for(int i = 0; i<32; i++) begin
      a_i <= $random % 2;
      @(posedge clk);
      previous_a <= a_i;
      flag1 = Compare_values("rising edge", exp_rising, rising_edge_o);
      flag2 = Compare_values("falling edge", exp_falling, falling_edge_o);
      Test_check(flag1, flag2, (i+2));
    end
    $finish();
  end

endmodule
