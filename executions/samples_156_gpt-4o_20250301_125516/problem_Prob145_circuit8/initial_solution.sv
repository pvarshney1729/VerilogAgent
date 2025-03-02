module TopModule (
    input wire clock,  // Clock input, assumed active on rising edge
    input wire a,      // 1-bit input signal
    output reg p,      // 1-bit output signal
    output reg q       // 1-bit output signal
);

    reg prev_p; // Register to hold the previous state of p

    always @(posedge clock) begin
        p <= a; // p directly follows a

        // q retains its previous state unless p transitions from 0 to 1
        if (prev_p == 0 && p == 1) begin
            q <= 0;
        end else begin
            q <= q;
        end

        prev_p <= p; // Update prev_p to the current state of p
    end

endmodule