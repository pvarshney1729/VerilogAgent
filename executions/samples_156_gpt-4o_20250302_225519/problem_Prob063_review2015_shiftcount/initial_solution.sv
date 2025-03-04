module TopModule (
    input  logic clk,           // Clock input, positive edge-triggered
    input  logic shift_ena,     // Shift enable, active high
    input  logic count_ena,     // Count enable, active high
    input  logic data,          // Data input, unsigned
    output logic [3:0] q        // 4-bit output register, unsigned
);

    // Initialize q to zero at the start
    initial begin
        q = 4'b0000;
    end

    always_ff @(posedge clk) begin
        if (shift_ena && !count_ena) begin
            // Shift operation
            q <= {q[2:0], data};
        end else if (count_ena && !shift_ena) begin
            // Down counter operation
            q <= q - 1;
        end
        // Undefined behavior if both shift_ena and count_ena are high
    end

endmodule