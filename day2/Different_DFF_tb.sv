// DFF TB

module Different_DFF_tb ();

  // Comparison Function Definition
  function automatic Compare_values(string msg, logic exp, logic act);
    begin
      // Perform Comparison
      if(exp !== act) begin
        $display("Error in %s Exp 0x%h Act 0x%h",msg, exp, act);
        return 1;
      end
      return 0;
    end
  endfunction
  
  logic clk;
  logic reset;
  
  logic d_i;
  
  logic q_norst_o;
  logic q_syncrst_o;
  logic q_asyncrst_o; 
  
  Different_DFF Different_DFF1(
    .clk(clk),
    .reset(reset),
    .d_i(d_i),
    .q_norst_o(q_norst_o),
    .q_syncrst_o(q_syncrst_o),
    .q_asyncrst_o(q_asyncrst_o)
  );

  logic exp_norst;
  logic exp_syncrst;
  logic exp_asyncrst;

  logic reset_vec [0:3] = {1'b0, 1'b0, 1'b1, 1'b1};
  logic d_i_vec [0:3] = {1'b0, 1'b1, 1'b0, 1'b1};

  logic flag1;
  logic flag2;
  logic flag3;

  // Exp calculation
  assign exp_norst = d_i;
  assign exp_syncrst = (reset) ? 1'b0 : d_i;
  assign exp_asyncrst = (reset) ? 1'b0 : d_i;
  
  //Generate clk
  always begin
    clk = 1'b1;
    #5; //wait 5 time units
    clk = 1'b0;
    #5;
  end
  
  //Start testing
  initial begin
    for(int i=0; i<4; i++) begin
      reset = reset_vec[i];
      d_i = d_i_vec[i];
      @(posedge clk);
      flag1 = Compare_values("no rst", exp_norst, q_norst_o);
      flag2 = Compare_values("sync rst", exp_syncrst, q_syncrst_o);
      flag3 = Compare_values("async rst", exp_asyncrst, q_asyncrst_o);
      if(!flag1 & !flag2 & !flag3) begin
        $display("Test %0d passed!",(i+1));
      end
    end
    $finish();
  end
endmodule
