module Parallel_to_Serial_Converter_tb ();

    // Comparison Function Definition
  function automatic Compare_values(string msg, logic [3:0] exp, logic [3:0] act, int num_test);
    begin
      // Perform Comparison
      if(exp !== act) begin
        $display("Error in %s Exp 0x%h Act 0x%h",msg, exp, act);
        return 1;
      end
      $display("Test %0d passed!", num_test);
    end
  endfunction

  logic clk;
  logic reset;
  logic [3:0] parallel_i;

  logic empty_o;
  logic serial_o;
  logic valid_o;

    Parallel_to_Serial_Converter Converter(
        .clk(clk),
        .reset(reset),
        .empty_o(empty_o),
        .parallel_i(parallel_i),
        .serial_o(serial_o),
        .valid_o(valid_o)
    );

    //Generate clk
    always begin
        clk = 1'b1;
        #5;
        clk = 1'b0;
        #5;
    end

logic exp_o;
logic exp_empty;
logic exp_valid;
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
assign exp_empty = ~(|counter_ff);

//Bitwise OR on counter to check if there is a valid bit
assign exp_valid = |counter_ff;

logic [3:0] shift_ff;
logic [3:0] next_shift;

always_ff@(posedge clk or posedge reset) begin
    if(reset)
        shift_ff <= 4'h0;
    else
        shift_ff <= next_shift;
end

assign next_shift = exp_empty ? parallel_i : {1'b0, shift_ff[3:1]};

assign exp_o = shift_ff[0];


   initial begin
    reset <= 1'b1;
    parallel_i <= 4'h0;
    @(posedge clk);
    Compare_values("Serial Output", exp_o, serial_o, 1);
    Compare_values("Empty Output", exp_empty, empty_o, 1);
    Compare_values("Valid Output", exp_valid, valid_o, 1);


    reset <= 1'b0;
    @(posedge clk);
    for(int i=2; i<34; i++) begin
        parallel_i <= $urandom_range(0,4'hF);
        @(posedge clk);
        Compare_values("Serial Output", exp_o, serial_o, i);
        Compare_values("Empty Output", exp_empty, empty_o, i);
        Compare_values("Valid Output", exp_valid, valid_o, i);
    end
    $finish();
end
endmodule