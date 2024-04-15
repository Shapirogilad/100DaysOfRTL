// Odd counter

module Odd_Counter (
  input     wire        clk,
  input     wire        reset,
  output    logic[7:0]  cnt_o
);

    logic [7:0] next_cnt;
    assign next_cnt = cnt_o + 8'h2;

  always@(posedge clk or posedge reset) begin
    if(reset)
        cnt_o <= 8'h1;
    else
        cnt_o <= next_cnt;
  end
endmodule
