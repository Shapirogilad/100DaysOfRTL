// Round robin arbiter

module Round_robin_arbiter (
  input     wire        clk,
  input     wire        reset,

  input     wire[3:0]   req_i,
  output    logic[3:0]  gnt_o
);

logic [3:0] mask_signal;
logic [3:0] next_mask_signal;
logic [3:0] mask_req;

always_ff @( posedge clk or posedge reset ) begin
  if(reset)
    mask_signal <= 0;
  else
    mask_signal <= next_mask_signal;
 end

 assign mask_req = req_i & mask_signal; // convert req_i to one-hot according to priority


 assign next_mask_signal = (gnt_o[0]) ? 4'b1110 :
                        (gnt_o[1]) ? 4'b1100 :
                        (gnt_o[2]) ? 4'b1000 :
                        (gnt_o[3]) ? 4'b0000 :
                                      mask_signal; //as soon one slot is granted, it must be blocked in a cyclic order for the next cycle
                              
logic [3:0] mask_gnt;
logic [3:0] regular_gnt;

Fixed_priority_arbiter #(4) MASK_GNT (
  .req_i (mask_req), 
  .gnt_o (mask_gnt)
  );

Fixed_priority_arbiter #(4) REGULAR_GNT (
  .req_i (req_i), 
  .gnt_o (regular_gnt)
  );

  assign gnt_o = (|mask_req) ? mask_gnt : regular_gnt;









endmodule
