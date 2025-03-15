module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    // Register to hold the output value
    logic [2:0] q_reg;

    // Initialize q to 'x' at the start of simulation
    initial begin
        q_reg = 3'bxxx;
    end

    // Sequential logic to update q_reg on the rising edge of clk
    always @(posedge clk) begin
        if (a) begin
            q_reg <= 3'b100; // Set q to 4 when a is 1
        end else begin
            q_reg <= q_reg + 1; // Increment q when a is 0
        end
    end

    // Assign the register value to the output
    assign q = q_reg;

endmodule