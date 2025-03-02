module enhanced_counter (
    input logic clk,
    input logic reset,
    input logic [3:0] in,
    output logic [3:0] out,
    output logic overflow
);

    logic [3:0] count;

    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
            overflow <= 1'b0;
        end else begin
            {overflow, count} <= count + in;
        end
    end

    assign out = count;

endmodule

module tb_enhanced_counter;
    logic clk;
    logic reset;
    logic [3:0] in;
    logic [3:0] out;
    logic overflow;

    enhanced_counter uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out),
        .overflow(overflow)
    );

    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        in = 4'b0000;

        // Apply reset
        reset = 1;
        #10 reset = 0;

        // Test case 1: No overflow
        in = 4'b0010;
        #10;
        assert(out == 4'b0010 && overflow == 1'b0);

        // Test case 2: Overflow occurs
        in = 4'b1111;
        #10;
        assert(out == 4'b0001 && overflow == 1'b1);

        // Test case 3: Reset after overflow
        reset = 1;
        #10 reset = 0;
        assert(out == 4'b0000 && overflow == 1'b0);

        // Test case 4: Increment without overflow
        in = 4'b0100;
        #10;
        assert(out == 4'b0100 && overflow == 1'b0);

        $finish;
    end

    always #5 clk = ~clk; // Clock generation

endmodule