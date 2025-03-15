module A (
    input logic clk,
    input logic rst,
    input logic a,
    input logic b,
    output logic y
);
    always @(posedge clk) begin
        if (rst) begin
            y <= 1'b0;
        end else begin
            y <= a & b; // Example combinational logic
        end
    end
endmodule

module B (
    input logic clk,
    input logic rst,
    input logic c,
    input logic d,
    output logic z
);
    always @(posedge clk) begin
        if (rst) begin
            z <= 1'b0;
        end else begin
            z <= c | d; // Example combinational logic
        end
    end
endmodule