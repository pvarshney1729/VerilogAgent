module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    logic next_state;

    // Combinational Logic
    always @(*) begin
        if (b) begin
            next_state = a ^ state; // XOR operation when b is high
        end else begin
            next_state = a & state; // AND operation when b is low
        end
    end

    // Sequential Logic
    always_ff @(posedge clk) begin
        state <= next_state;
    end

    // Output assignment
    assign q = next_state;

endmodule