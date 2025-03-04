module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    // Internal register to hold the state of q
    logic [3:0] q_reg;

    // Initialize q_reg to 4'b0000
    initial begin
        q_reg = 4'b0000;
    end

    // Sequential logic for shift and count operations
    always_ff @(posedge clk) begin
        if (shift_ena && !count_ena) begin
            // Shift operation: Shift in data at MSB
            q_reg <= {data, q_reg[3:1]};
        end else if (!shift_ena && count_ena) begin
            // Count operation: Decrement by 1
            if (q_reg != 4'b0000) begin
                q_reg <= q_reg - 1;
            end
        end
        // If both shift_ena and count_ena are high, behavior is undefined
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule