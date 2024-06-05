module Round_robin_arbiter_tb ();

    // Comparison Function Definition
  function automatic Compare_values(string msg, logic [3:0] exp, logic [3:0] act, int num_test);
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
  logic [3:0] req_i;

  logic [3:0] gnt_o;

    Round_robin_arbiter DUT(
        .clk(clk),
        .reset(reset),
        .req_i(req_i),
        .gnt_o(gnt_o)
    );

    //Generate clk
    always #5 clk = !clk;


      task automatic REGULAR;
        begin
            $write("%c[1;34m",27);
            $display("Regular");
            $write("%c[0m",27);
            reset = 1'b1;
            req_i = 4'b0;
            @(posedge clk);
            reset = 1'b0;
           // Compare_values("Check RESET", exp, gnt_o, 1);
            @(posedge clk)
            for(int i=2; i<30; i++) begin //random seq
              req_i = $urandom_range(0,4'hF);
              @(posedge clk);
           // Compare_values("Sequence Detector", exp, det_o, i);
            end
        end
    endtask 


   initial begin
      clk = 0;
      REGULAR;

      $finish();
    end
   
endmodule