// Simple shift register
module Shift_Register(
  input     wire        clk,
  input     wire        reset,
  input     wire        x_i,      // Serial input

  output    wire[3:0]   sr_o
);

  logic [3:0] next_sr;
  logic [3:0] sr_ff;

  assign next_sr = {sr_ff [2:0], x_i}; 
  assign sr_o = sr_ff;

    always@(posedge clk or posedge reset) begin
        if(reset)
            sr_ff <= 4'h0;
        else
            sr_ff <= next_sr;
    end

endmodule