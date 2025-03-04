module TopModule (
    input logic clk,            // Clock signal, triggers on positive edge
    input logic shift_ena,      // Enable for shift operation
    input logic count_ena,      // Enable for count operation
    input logic data,           // Input data for shifting (1 bit)
    output logic [3:0] q        // 4-bit output, representing the shift register/counter
);

    always_ff @(posedge clk) begin
        if (shift_ena && !count_ena) begin
            // Shift operation
            q <= {q[2:0], data};
        end else if (!shift_ena && count_ena) begin
            // Count operation
            q <= q - 1;
        end
        // If both shift_ena and count_ena are high, behavior is undefined
        // and no operation is performed.
    end

    // Initialize q to 4'b0000 at the start
    initial begin
        q = 4'b0000;
    end

endmodule