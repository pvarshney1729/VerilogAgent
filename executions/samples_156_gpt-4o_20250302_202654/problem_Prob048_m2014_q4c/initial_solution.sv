module TopModule (
    input logic clk,
    input logic d,
    input logic r,
    output logic q
);

// D flip-flop with synchronous active high reset
always_ff @(posedge clk) begin
    if (r) begin
        q <= 1'b0;  // Reset output to 0
    end else begin
        q <= d;     // Capture input d
    end
end

endmodule