module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    // Internal register to hold the current state of q
    logic [2:0] q_reg;

    // Sequential logic: Update q_reg on the rising edge of clk
    always_ff @(posedge clk) begin
        if (a) begin
            // If 'a' is high, retain the current value of q
            q_reg <= q_reg;
        end else begin
            // If 'a' is low, increment q with wrap-around logic
            q_reg <= (q_reg == 3'b110) ? 3'b000 : q_reg + 1;
        end
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule