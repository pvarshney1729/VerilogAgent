module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset state
        end else begin
            q <= {q[0] ^ q[2], q[4:1]}; // Shift right with feedback from taps at positions 5 and 3
        end
    end

endmodule