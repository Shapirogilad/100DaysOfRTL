module Binary_to_OneHot_Converter_tb();
  localparam BIN_W       = 4;
  localparam ONE_HOT_W   = 16;
    // Comparison Function Definition
  function automatic Compare_values(string msg, logic [ONE_HOT_W-1:0] exp, logic [ONE_HOT_W-1:0] act, int num_test);
    begin
      // Perform Comparison
      if(exp !== act) begin
        $display("Error in %s Exp 0x%b Act 0x%b",msg, exp, act);
        return 1;
      end
      $display("Test %0d passed!", num_test);
    end
  endfunction

logic [BIN_W-1:0] bin_i;
logic [ONE_HOT_W-1:0] one_hot_o;
logic [ONE_HOT_W-1:0] exp;

Binary_to_OneHot_Converter Converter1(
    .bin_i(bin_i),
    .one_hot_o(one_hot_o)
);
assign exp = (bin_i < ONE_HOT_W) ? (1'b1 << bin_i) : 0;

initial begin
    for(int i=1; i < 33; i++) begin
      bin_i = $urandom_range (0,{BIN_W{1'b1}});
      #5;
      Compare_values("Converter", exp, one_hot_o,i);
    end
    $finish();
end
endmodule