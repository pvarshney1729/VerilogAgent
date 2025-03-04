module TopModule (
    input  logic clk,            // Clock signal, positive-edge triggered
    input  logic a,              // Unsigned 1-bit input signal
    input  logic b,              // Unsigned 1-bit input signal
    output logic out_assign,     // Unsigned 1-bit output from assign statement
    output logic out_always_comb,// Unsigned 1-bit output from combinational always block
    output logic out_always_ff   // Unsigned 1-bit output from sequential always block (flip-flop)
);

    // Combinational logic using assign
    assign out_assign = a ^ b;

    // Combinational logic using always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential logic using always block with positive-edge triggered clock
    always @(posedge clk) begin
        out_always_ff <= a ^ b;  // Initialize to 0 if reset is not used
    end

endmodule