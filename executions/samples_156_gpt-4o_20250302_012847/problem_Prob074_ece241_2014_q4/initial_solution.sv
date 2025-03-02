module TopModule (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    input logic c,
    output logic y
);

    logic q1, q2, q3;
    logic xor_out, and_out, or_out;

    // D Flip-Flop with synchronous reset for q1
    always_ff @(posedge clk) begin
        if (reset) begin
            q1 <= 1'b0;
        end else begin
            q1 <= a ^ b; // XOR operation
        end
    end

    // D Flip-Flop with synchronous reset for q2
    always_ff @(posedge clk) begin
        if (reset) begin
            q2 <= 1'b0;
        end else begin
            q2 <= a & c; // AND operation
        end
    end

    // D Flip-Flop with synchronous reset for q3
    always_ff @(posedge clk) begin
        if (reset) begin
            q3 <= 1'b0;
        end else begin
            q3 <= b | c; // OR operation
        end
    end

    // Combinational logic for output y
    always @(*) begin
        y = ~(q1 | q2 | q3); // NOR operation
    end

endmodule