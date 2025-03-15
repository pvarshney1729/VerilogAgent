module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    // Internal register to hold the previous state of 'in'
    logic [7:0] in_prev;

    // Always block to detect edges on the rising edge of the clock
    always @(posedge clk) begin
        // Shift the current input 'in' to 'in_prev' at the next clock cycle
        in_prev <= in;

        // Detect positive edges and set the 'pedge' output accordingly
        pedge <= (in & ~in_prev);
    end

    // Initialize 'pedge' to 0 during simulation
    initial begin
        pedge = 8'b00000000;
        in_prev = 8'b00000000;
    end

endmodule