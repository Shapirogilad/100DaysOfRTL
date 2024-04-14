// A simple TB for mux

module Mux_tb ();

  logic [7:0] a_i;
  logic [7:0] b_i;
  logic sel_i;
  logic [7:0] y_o;
  
  Mux MUX1 (
    .a_i(a_i),
    .b_i(b_i),
    .sel_i(sel_i),
    .y_o(y_o)
  );

  logic [7:0] exp;
  logic flag = 1'b0;

  
  
  initial begin
    for(int i=0; i < 10; i++) begin
      a_i = $urandom_range (0,8'hFF);
      b_i = $urandom_range (0,8'hFF);
      sel_i = $urandom_range (0,1);
      #5;
      assign exp = sel_i ? b_i : a_i;
      if(exp != y_o) begin
        $display("Error! Exp 0x%h Act 0x%h", exp, y_o);
        flag = 1'b1;
      end
    end
    if(flag == 1'b0) begin
      $display("Test passed!");
    end
    $finish();
  end
endmodule