module TopModule (
    input  logic clock,          // Clock signal (1-bit input)
    input  logic a,              // Input signal (1-bit input)
    output logic p,              // Output signal p (1-bit output)
    output logic q               // Output signal q (1-bit output)
);

    // Initial states
    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    // Sequential logic
    always @(posedge clock) begin
        if (a) begin
            p <= 1'b1;
            q <= 1'b0;
        end else begin
            q <= ~q; // Toggle q on every clock cycle when a is low
        end
    end

endmodule