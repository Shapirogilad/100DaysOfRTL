//Shift Register tb
module Shift_Register_tb ();

// Comparison Function Definition
  function automatic Compare_values(string msg, logic [3:0] exp, logic [3:0] act);
    begin
      // Perform Comparison
      if(exp !== act) begin
        $display("Error in %s Exp 0x%h Act 0x%h",msg, exp, act);
        return 1;
      end
      return 0;
    end
  endfunction

  function automatic void Test_check(logic flag, int num_test);
    begin
      if(!flag) begin
        $display("Test %0d passed!", num_test);
      end
    end
  endfunction

logic clk;
logic reset;
logic x_i;
logic [3:0] sr_o;

Shift_Register Shift_Register1(
    .clk(clk),
    .reset(reset),
    .x_i(x_i),
    .sr_o(sr_o)
);

 //Generate clk
  always begin
    clk = 1'b1;
    #5; //wait 5 time units
    clk = 1'b0;
    #5;
  end

logic [3:0] exp;
logic [3:0] next_sr;

assign next_sr = {exp [2:0], x_i}; 

always@(posedge clk or posedge reset) begin
    if(reset)
        exp <= 4'h0;
    else
        exp <= next_sr;
end

initial begin
    reset <= 1'b1;
    x_i <= 1'b0;
    @(posedge clk);
    Test_check(Compare_values("Shift Register", exp, sr_o),1);


    reset <= 1'b0;
    for(int i=0; i<10; i++) begin
        x_i <= $random % 2;
        @(posedge clk);
        Test_check(Compare_values("Shift Register", exp, sr_o),(i+2));
    end
    $finish();
end
endmodule