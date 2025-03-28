module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic q
);

    always @(*) begin
        // Implement the combinational logic based on the truth table
        if (a == 1 && b == 0) begin
            if (c == 1 && d == 1) q = 1; // 70ns case
            else if (c == 1 && d == 0) q = 1; // 65ns case
            else q = 0; // 55ns and 60ns cases
        end else if (a == 0 && b == 1) begin
            if (c == 1) q = 1; // 45ns, 50ns cases
            else q = 1; // 35ns, 40ns cases
        end else if (a == 0 && b == 0) begin
            if (c == 1) begin
                if (d == 1) q = 1; // 30ns case
                else q = 1; // 25ns case
            end else if (d == 1) q = 0; // 20ns case
            else q = 0; // 0ns - 15ns cases
        end else if (a == 1 && b == 1) begin
            q = 1; // 75ns to 90ns cases
        end else begin
            q = 0; // Default case
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly