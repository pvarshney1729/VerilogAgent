module TopModule (
    input  logic clk,
    input  logic d,
    output logic q
);
    logic d_latched;

    // Capture the input d on the rising edge of clk
    always @ (posedge clk) begin
        d_latched <= d;
    end

    // Capture the input d on the falling edge of clk
    always @ (negedge clk) begin
        q <= d_latched;
    end

    // Ensure q reflects d on both edges
    always @ (posedge clk or negedge clk) begin
        q <= d;
    end

    // Initial condition for simulation
    initial begin
        q = 1'b0; // Initialize q to 0
    end

endmodule