module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset to 1
        end else begin
            // Shift right and apply XOR feedback for taps at positions 5 and 3
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end

endmodule