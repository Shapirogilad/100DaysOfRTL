module APB_Master_tb ();

    // Comparison Function Definition
  function automatic Compare_values(string msg, logic exp, logic act, int num_test);
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

logic clk;
logic reset;
logic [1:0] cmd_i,
logic psel_o,
logic penable_o,
logic [31:0] paddr_o,
logic pwrite_o,
logic [31:0] pwdata_o,
logic pready_i,
logic [31:0] prdata_i

APB_Master DUT(.*);

//Generate clk
always #5 clk = !clk;

logic exp;// must update from here


task automatic REGULAR;
  begin
      $write("%c[1;34m",27);
      $display("Regular");
      $write("%c[0m",27);
      reset = 1'b1;
      x_i = 1'b1;
      @(posedge clk);
      reset = 1'b0;
      @(posedge clk)
      for(int i=0; i<12; i++) begin //success
        x_i = seq[i];
        @(posedge clk);
        Compare_values("Sequence Detector", exp, det_o, i+1);
      end
      for(int i=13; i<100; i++) begin //random seq
        x_i = $random%2;
        @(posedge clk);
      Compare_values("Sequence Detector", exp, det_o, i);
      end
  end
endtask 


initial begin
   clk = 0;
   REGULAR;
   $finish();
 end
   
endmodule