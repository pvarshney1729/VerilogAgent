module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    initial begin
        q = 3'b000; // Initial state of q
    end

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // Hold at 4 when a is high
        end else begin
            q <= (q + 1) % 8; // Increment q when a is low
        end
    end

endmodule