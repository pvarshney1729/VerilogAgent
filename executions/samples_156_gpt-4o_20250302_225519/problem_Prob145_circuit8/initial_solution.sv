module TopModule(
    input logic clock,  // Clock signal
    input logic a,      // 1-bit input signal
    output logic p,     // 1-bit output signal
    output logic q      // 1-bit output signal
);

    logic prev_p; // To store the previous state of p

    // Initial block to set initial states
    initial begin
        p = 1'b0;
        q = 1'b0;
        prev_p = 1'b0;
    end

    // Sequential logic for p and q
    always_ff @(posedge clock) begin
        prev_p <= p; // Store the previous state of p
        p <= a;      // Update p based on input a

        // Update q based on the transition of p
        if (prev_p == 1'b0 && p == 1'b1) begin
            q <= 1'b1;
        end else begin
            q <= q; // Retain the previous value of q
        end
    end

endmodule