module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Internal register to hold the state of q
    logic q_reg;

    // Initial conditions
    initial begin
        p = 1'b0;
        q_reg = 1'b0;
    end

    // Sequential logic for p and q
    always_ff @(posedge clock) begin
        p <= a;          // p follows the state of a on the rising edge of clock
        q_reg <= ~q_reg; // q toggles on every rising edge of clock
    end

    // Assign the internal register to the output q
    assign q = q_reg;

endmodule