// Different DFF

module Different_DFF (
  input     logic      clk,
  input     logic      reset,

  input     logic      d_i,

  output    logic      q_norst_o,
  output    logic      q_syncrst_o,
  output    logic      q_asyncrst_o
);

//non-resettable flop
  always@(posedge clk)
    begin
      q_norst_o <= d_i;
    end
  
//flop using synchronous reset
  always@(posedge clk or posedge reset)
    begin
      if(reset)
        q_syncrst_o <= 1'b0;
      else
        q_syncrst_o <= d_i;
    end
//flop using asynchrnoous reset
  always@(posedge clk or negedge reset)
    begin
      if(~reset)
        q_asyncrst_o <= 1'b0;
      else
        q_asyncrst_o <= d_i;
    end

endmodule
