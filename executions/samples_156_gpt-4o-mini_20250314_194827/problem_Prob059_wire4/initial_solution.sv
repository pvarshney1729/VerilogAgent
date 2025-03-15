module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic clk,
    input logic rst,
    output logic w,
    output logic x,
    output logic y,
    output logic z
);

    // Combinational logic for outputs
    always @(*) begin
        w = (a & b) | (~c);
        x = (a | b) & c;
        y = (a ^ b) & (~c);
        z = (a & ~b) | (b & c);
    end

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (rst) begin
            w <= 1'b0;
            x <= 1'b0;
            y <= 1'b0;
            z <= 1'b0;
        end else begin
            // Update outputs based on combinational logic
            w <= w;
            x <= x;
            y <= y;
            z <= z;
        end
    end

endmodule