module TopModule (
    input logic clk,      // 1-bit clock signal
    input logic a,        // 1-bit input signal
    input logic b,        // 1-bit input signal
    output logic q,       // 1-bit output signal
    output logic state    // 1-bit state of the flip-flop
);

    initial begin
        q = 1'b0;         // Initialize output q to 0
        state = 1'b0;     // Initialize state to 0
    end

    always @(posedge clk) begin
        state <= q;       // Update state with current output q
        if (a == 1'b0) begin
            q <= 1'b0;    // If a is 0, set q to 0
        end else if (a == 1'b1 && b == 1'b1) begin
            q <= ~q;      // If both a and b are 1, toggle q
        end
        // If a is 1 and b is 0, maintain previous state of q
    end

endmodule