module B (
    input logic clk,
    input logic rst_n,
    input logic a,
    input logic b,
    output logic y
);

always @(*) begin
    if (!rst_n) begin
        y = 1'b0; // Reset output to 0
    end else begin
        // Implement the combinational logic based on the truth table
        y = (a & b) | (~a & ~b); // Example logic, replace with actual logic from truth table
    end
end

endmodule