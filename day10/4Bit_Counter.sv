// Counter with a load
module Four_Bit_Counter (
  input     wire          clk,
  input     wire          reset,
  input     wire          load_i,
  input     wire[3:0]     load_val_i,

  output    wire[3:0]     count_o
);


  logic [3:0] count_ff;
  logic [3:0] count_next;
  logic [3:0] load_ff;

  assign count_o = count_ff;
  assign count_next = load_i ? load_ff : ( (count_ff == 4'hF) ? load_ff : count_ff + 4'h1); 

  always@(posedge clk or posedge reset) begin
    if(reset)
        count_ff <= 4'h0;
    else
        count_ff <= count_next;
  end

  always@(posedge clk or posedge reset) begin
    if(reset)
        load_ff <= 4'h0;
    else
        load_ff <= load_val_i;
  end

endmodule
