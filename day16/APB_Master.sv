// APB(Advanced Peripheral Bus) Master

// TB should drive a cmd_i input decoded as:
//  - 2'b00 - No-op
//  - 2'b01 - Read from address 0xDEAD_CAFE
//  - 2'b10 - Increment the previously read data and store it to 0xDEAD_CAFE

module APB_Master (
  input       wire        clk,
  input       wire        reset,

  input       wire[1:0]   cmd_i,

  output      wire        psel_o,
  output      wire        penable_o,
  output      wire[31:0]  paddr_o,
  output      wire        pwrite_o,
  output      wire[31:0]  pwdata_o,
  input       wire        pready_i,
  input       wire[31:0]  prdata_i
);

enum logic [1:0] {IDLE, SETUP, ACCESS} state , next_state ;
logic [31:0] rdata;

always_ff @(posedge clk or posedge reset) begin
  if(reset)
    state <= IDLE;
  else
    state <= next_state;
  end

always_ff @(posedge clk or posedge reset) begin
  if(reset)
    rdata <= 32'h0;
  else if(penable_o && pready_i)
    rdata <= prdata_i;
end

assign psel_o = ~(state == IDLE);
assign penable_o = (state == ACCESS);
assign paddr_o = 32'hDEAD_CAFE;
assign pwrite_o = cmd_i[1];
assign pwdata_o = rdata + 32'h1;


always_comb begin
  case (state)
    IDLE: next_state = (|cmd_i) ? SETUP : IDLE;
    SETUP: next_state = ACCESS;
    ACCESS: next_state = (pready_i) ? IDLE : ACCESS;
    default: next_state = state;
  endcase
end







endmodule
