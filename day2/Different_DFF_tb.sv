// DFF TB

module Different_DFF_tb ();
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
  
  //Generate clk
  always begin
    clk = 1'b1;
    #5; //wait 5 time units
    clk = 1'b0;
    #5;
  end
  
  //Start testing
  initial begin
    reset = 1'b1;
    d_i = 1'b0;
    @(posedge clk); //waiting for the clk to rise
    
    reset = 1'b0;
    @(posedge clk);
    
    d_i = 1'b1;
    @(posedge clk);
    @(posedge clk);
    @(negedge clk);
    
    reset = 1'b1;
    @(posedge clk);
    @(posedge clk);
    
    reset = 1'b0;
    @(posedge clk);
    @(posedge clk);
    $finish();
  end
endmodule
