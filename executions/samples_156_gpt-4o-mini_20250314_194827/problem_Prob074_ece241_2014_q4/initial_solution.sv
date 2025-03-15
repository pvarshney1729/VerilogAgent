module my_module (
    input logic clk,
    input logic rst_n,
    input logic a,
    input logic b,
    output logic y
);

logic dff_out;

always @(*) begin
    y = a & b; // Example combinational logic (AND gate)
end

always @(posedge clk) begin
    if (!rst_n) begin
        dff_out <= 1'b0; // Asynchronous reset
    end else begin
        dff_out <= y; // D flip-flop behavior
    end
end

endmodule