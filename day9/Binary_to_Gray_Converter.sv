// Binary to gray converter

module Binary_to_Gray_Converter #(
  parameter VEC_W = 4
)(
  input     wire[VEC_W-1:0] bin_i,
  output    wire[VEC_W-1:0] gray_o 
);

assign gray_o[VEC_W-1] = bin_i [VEC_W-1];

genvar i;
for(i=0; i<VEC_W-1; i++) begin
  assign gray_o[VEC_W-2-i] = bin_i[VEC_W-1-i] ^ bin_i[VEC_W-2-i];
end

endmodule