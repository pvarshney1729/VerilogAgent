module TopModule (
    input wire d,           // Data input for the D latch
    input wire ena,         // Enable signal for the D latch
    output reg q            // Output of the D latch
);

    always @(*) begin
        if (ena) begin
            q = d;  // Latch is transparent
        end
        // else q retains its previous state
    end

endmodule