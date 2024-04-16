module Binary_to_Gray_Converter_tb();
  localparam VEC_W = 4;

    // Comparison Function Definition
  function automatic Compare_values(string msg, logic [VEC_W-1:0] exp, logic [VEC_W-1:0] act, int num_test);
    begin
      // Perform Comparison
      if(exp !== act) begin
        $display("Error in %s Exp %b Act %b",msg, exp, act);
        return 1;
      end
      $display("Test %0d passed!", num_test);
    end
  endfunction

logic [VEC_W-1:0] bin_i;
logic [VEC_W-1:0] gray_o;
logic [VEC_W-1:0] exp;

Binary_to_Gray_Converter Converter1(
    .bin_i(bin_i),
    .gray_o(gray_o)
);
assign exp [VEC_W-1] = bin_i[VEC_W-1];
genvar i;
for(i=0; i<VEC_W-1; i++) begin
  assign exp[VEC_W-2-i] = bin_i[VEC_W-1-i] ^ bin_i[VEC_W-2-i];
end

initial begin
    for(int i=1; i < 16; i++) begin
      bin_i = $urandom_range (0,{VEC_W{1'b1}});
      #5;
      Compare_values("Converter", exp, gray_o, i);
    end
    $finish();
end
endmodule