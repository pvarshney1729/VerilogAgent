module TopModule (
    input logic clk,        // Clock signal, 1-bit
    input logic a,          // Input signal, 1-bit
    output logic [2:0] q    // Output signal, 3-bits (MSB: q[2], LSB: q[0])
);

    // Internal register to hold the state of q
    logic [2:0] q_reg;

    // Initialize q to 3'b000
    initial begin
        q_reg = 3'b000;
    end

    // Sequential logic to update q on the rising edge of clk
    always_ff @(posedge clk) begin
        if (a == 1'b0) begin
            if (q_reg == 3'b111) begin
                q_reg <= 3'b000; // Wrap around to 3'b000 after reaching 3'b111
            end else begin
                q_reg <= q_reg + 1'b1; // Increment q by 1
            end
        end
        // If a is 1, hold the current value of q_reg
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule