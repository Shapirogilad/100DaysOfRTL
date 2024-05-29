module Various_mux_tb ();

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

  logic [3:0] a_i;
  logic [3:0] sel_i;

  logic y_ter_o;
  logic y_case_o;
  logic y_ifelse_o;
  logic y_loop_o;
  logic y_aor_o;

    Various_mux mux(.*); //connect all inputs and outputs to the same name


logic [3:0] exp;

assign exp =      sel_i[0] ? a_i[0] :
                  sel_i[1] ? a_i[1] :
                  sel_i[2] ? a_i[2] :
                             a_i[3];

      task automatic RANDOMֹ_SEQUENCES;
        begin
            $write("%c[1;34m",27);
            $display("RANDOMֹ SEQUENCES");
            $write("%c[0m",27);
      
            for(int i=0; i<32; i++) begin
              a_i = $urandom_range(0, 4'hF);
              sel_i = 1'b1 << $urandom_range(0, 2'h3); //The random number determines the number of positions to shift the binary value 1'b1
              Compare_values("Ternary Mux", exp, y_ter_o, i+1);
              Compare_values("Case Mux", exp, y_case_o, i+1);
              Compare_values("If-Else Mux", exp, y_ifelse_o, i+1);
              Compare_values("Loop Mux", exp, y_loop_o, i+1);
              Compare_values("And-Or-Tree Mux", exp, y_aor_o, i+1);
              #5;
            end
        end
    endtask 


   initial begin
      RANDOMֹ_SEQUENCES;

      $finish();
    end
   
endmodule