module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    // Initialize q to 0x34 in simulation
    initial begin
        q = 8'h34;
    end

    // 8 D flip-flops with active high synchronous reset
    always_ff @(negedge clk) begin
        if (reset) begin
            q <= 8'h34;
        end else begin
            q <= d;
        end
    end

endmodule