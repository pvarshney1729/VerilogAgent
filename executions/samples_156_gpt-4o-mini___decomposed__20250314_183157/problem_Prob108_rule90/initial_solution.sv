module TopModule(
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] q_reg, q_next;

    always @(posedge clk) begin
        if (load) begin
            q_reg <= data;
        end else begin
            q_reg[0] <= 1'b0; // Boundary condition
            q_reg[511] <= 1'b0; // Boundary condition
            for (integer i = 1; i < 511; i = i + 1) begin
                q_next[i] = q_reg[i-1] ^ q_reg[i+1]; // Rule 90 logic
            end
            q_reg[1:510] <= q_next[1:510]; // Update the state
        end
    end

    assign q = q_reg;

endmodule