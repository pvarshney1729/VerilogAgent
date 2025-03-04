module TopModule (
    input logic clk,      // Clock input, active on the rising edge
    input logic a,        // 1-bit input signal
    output logic [2:0] q  // 3-bit output register, bits indexed as q[2:0] where q[0] is LSB
);

    // Internal register to hold the state of q
    logic [2:0] q_reg;

    // Synchronous logic for q with synchronous reset
    always_ff @(posedge clk) begin
        if (a == 1'b0) begin
            if (q_reg == 3'b111) begin
                q_reg <= 3'b000;  // Wrap around from 7 to 0
            end else begin
                q_reg <= q_reg + 1'b1;  // Increment q
            end
        end
        // If a == 1, q_reg holds its value
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule