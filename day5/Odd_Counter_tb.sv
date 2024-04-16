//Odd_Counter_tb
module Odd_Counter_tb();

// Comparison Function Definition
  function automatic Compare_values(string msg, logic [7:0] exp, logic [7:0] act, int num_test);
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
    logic [7:0] cnt_o;

    Odd_Counter Odd_Counter1(
        .clk(clk),
        .reset(reset),
        .cnt_o(cnt_o)
    );

    //Generate clk
    always begin
        clk = 1'b1;
        #5;
        clk = 1'b0;
        #5;
    end

    logic [7:0] exp_cnt;

    
    always@(posedge clk or posedge reset) begin
        if(reset)
            exp_cnt <= 8'h1;
        else
            exp_cnt <= exp_cnt + 8'h2; 
    end

    //Start Testing
initial begin
    reset <= 1'b1;
    @(posedge clk);
    Compare_values("Compare", exp_cnt, cnt_o, 1);

    reset <= 1'b0;
    for(int i = 2; i<130 ; i++) begin
        @(posedge clk)
        Compare_values("Compare", exp_cnt, cnt_o, i);
    end
    $finish();
end
endmodule