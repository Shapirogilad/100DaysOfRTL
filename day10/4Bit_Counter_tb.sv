//4Bit_Counter_tb
module Four_Bit_Counter_tb();

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
    logic load_i;
    logic [3:0] load_val_i;
    logic [3:0] count_o;

    Four_Bit_Counter Counter1(
        .clk(clk),
        .reset(reset),
        .load_i(load_i),
        .load_val_i(load_val_i),
        .count_o(count_o)
    );

    //Generate clk
    always begin
        clk = 1'b1;
        #5;
        clk = 1'b0;
        #5;
    end

    logic [3:0] exp_count;

    logic [3:0] count_ff;
    logic [3:0] count_next;
    logic [3:0] load_ff;

    assign exp_count = count_ff;
    assign count_next = load_i ? load_ff : ( (count_ff == 4'hF) ? load_ff : count_ff + 4'h1); 

    always@(posedge clk or posedge reset) begin
        if(reset)
            count_ff <= 4'h0;
        else
            count_ff <= count_next;
    end

    always@(posedge clk or posedge reset) begin
        if(reset)
            load_ff <= 4'h0;
        else
            load_ff <= load_val_i;
    end

    //Start Testing
    initial begin
        reset <= 1'h1;
        @(posedge clk);
        Compare_values("Compare", exp_count, count_o, 1);

        reset <= 1'h0;
        for(int i = 2; i<17 ; i++) begin
            load_i <= $random % 2;
            load_val_i <= $urandom_range (0,4'hF);
            @(posedge clk)
            Compare_values("Compare", exp_count, count_o, i);
        end
        $finish();
    end
endmodule