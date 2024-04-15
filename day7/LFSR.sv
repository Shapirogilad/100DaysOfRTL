// LFSR - linear feedback shift register
module LFSR (
  input     wire      clk,
  input     wire      reset,

  output    wire[3:0] lfsr_o
);

  logic [3:0] next_lfsr;
  logic [3:0] lfsr_ff;

  assign next_lfsr = {lfsr_ff [2:0], lfsr_ff[3] ^ lfsr_ff[1]}; 
  assign lfsr_o = lfsr_ff;

    always@(posedge clk or posedge reset) begin
        if(reset)
            lfsr_ff <= 4'h0;
        else
            lfsr_ff <= next_lfsr;
    end

endmodule