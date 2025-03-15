module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [4:0] q
);

    // Initialize the output register
    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset to 1
            q <= 5'b00001;
        end else begin
            // Galois LFSR operation
            q[4] <= q[4] ^ q[2]; // New MSB from XOR of tap bits
            q[3] <= q[4];        // Shift right
            q[2] <= q[3];        // Shift right
            q[1] <= q[2];        // Shift right
            q[0] <= q[1];        // Shift right
        end
    end

    // Initialize q to a known state for simulation purposes
    initial begin
        q = 5'b00001; // Initial state
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly