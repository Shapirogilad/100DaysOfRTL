// Parallel to serial with valid and empty

module Parallel_to_Serial_Converter (
  input     wire      clk,
  input     wire      reset,

  output    wire      empty_o,
  input     wire[3:0] parallel_i,
  
  output    wire      serial_o,
  output    wire      valid_o
);
//counter
logic [2:0] counter_ff;
logic [2:0] next_count;

always_ff@(posedge clk or posedge reset) begin
    if(reset)
        counter_ff <= 3'h0;
    else
        counter_ff <= next_count;
end

//counter resets when it reaches 4
assign next_count = (counter_ff == 3'h4) ? 3'h0 : (counter_ff + 3'h1);

//Bitwise OR on counter to check if empty
assign empty_o = ~(|counter_ff);

//Bitwise OR on counter to check if there is a valid bit
assign valid_o = |counter_ff;

logic [3:0] shift_ff;
logic [3:0] next_shift;

always_ff@(posedge clk or posedge reset) begin
    if(reset)
        shift_ff <= 3'h0;
    else
        shift_ff <= next_shift;
end

assign next_shift = empty_o ? parallel_i : {1'b0, shift_ff[3:1]};

assign serial_o = shift_ff[0];

endmodule