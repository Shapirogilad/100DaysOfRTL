module Fixed_priority_arbiter_tb ();

localparam NUM_PORTS = 8;

// Comparison Function Definition
  function automatic Compare_values(string msg, logic [NUM_PORTS-1:0] exp, logic [NUM_PORTS-1:0] act, int num_test);
    begin
      // Perform Comparison
      if(exp !== act) begin
        $write("%c[1;91m",27);
        $display("Error in %s Exp 0x%h Act 0x%h",msg, exp, act);
        $write("%c[0m",27);
        return 1;
      end
    $write("%c[1;92m",27);
    $display("Test %0d passed!", num_test);
    $write("%c[0m",27);
    end
  endfunction

logic [NUM_PORTS-1:0] req_i;
logic [NUM_PORTS-1:0] gnt_o;


    Fixed_priority_arbiter #(NUM_PORTS) Arbiter(
        .req_i(req_i),
        .gnt_o(gnt_o)
    );


logic [NUM_PORTS-1:0] exp;

assign exp[0] = req_i[0];
genvar i;
for (i=1; i<NUM_PORTS; i=i+1) begin
  assign exp[i] = req_i[i] & ~(|exp[i-1:0]);
end

      task automatic REGULAR;
        begin
            $write("%c[1;34m",27);
            $display("Regular");
            $write("%c[0m",27);
            for (int i=0; i<32; i=i+1) begin
                req_i = $urandom_range(0, 2**NUM_PORTS-1);
                #5;
                Compare_values("Priority arbiter", exp, gnt_o, i+1);
            end
        end
      endtask


   initial begin
      REGULAR;

      $finish();
    end
   
endmodule