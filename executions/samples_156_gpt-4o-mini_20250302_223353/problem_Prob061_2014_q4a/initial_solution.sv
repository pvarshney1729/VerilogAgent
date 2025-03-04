module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= w;
        end
        // Q retains its value if neither L nor E are asserted
    end

    initial begin
        Q = 1'b0; // Initialize Q to 0
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly