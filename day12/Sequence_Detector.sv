// Detecting a big sequence - 1110_1101_1011
module Sequence_Detector (
  input     wire        clk,
  input     wire        reset,
  input     wire        x_i,

  output    wire        det_o
);

  reg [11:0] shift_ff;
  wire [11:0] next_shift;

  always_ff @( posedge clk or posedge reset ) begin
    if(reset)
      shift_ff <= 12'b0;
    else
      shift_ff <= next_shift;
  end

  assign next_shift = {shift_ff[10:0], x_i};
  assign det_o = (shift_ff == 12'b1110_1101_1011);

endmodule