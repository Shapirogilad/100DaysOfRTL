//LFSR tb
module LFSR_tb ();

  // Comparison Function Definition
  function automatic Compare_values(string msg, logic [3:0] exp, logic [3:0] act, int num_test);
    begin
      // Perform Comparison
      if(exp !== act) begin
        $display("Error in %s Exp 0x%h Act 0x%h",msg, exp, act);
        return 1;
      end
      $display("Test %0d passed!", num_test);
    end
  endfunction

logic clk;
logic reset;
logic [3:0] lfsr_o;

LFSR LFSR1(
    .clk(clk),
    .reset(reset),
    .lfsr_o(lfsr_o)
);

 //Generate clk
  always begin
    clk = 1'b1;
    #5; //wait 5 time units
    clk = 1'b0;
    #5;
  end

logic [3:0] exp;
logic [3:0] next_lfsr;

assign next_lfsr = {exp [2:0], exp[3] ^ exp[1]}; 

always@(posedge clk or posedge reset) begin
    if(reset)
        exp <= 4'h0;
    else
        exp <= next_lfsr;
end

initial begin
    reset <= 1'b1;
    @(posedge clk);
    Compare_values("LFSR", exp, lfsr_o,1);


    reset <= 1'b0;
    for(int i=2; i<34; i++) begin
        @(posedge clk);
        Compare_values("LFSR", exp, lfsr_o,i);
    end
    $finish();
end
endmodule