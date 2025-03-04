module TopModule (
    input logic clk,               // Clock input, positive edge-triggered
    input logic areset,            // Active high asynchronous reset
    input logic [7:0] d,           // 8-bit data input, bit[0] is LSB
    output logic [7:0] q           // 8-bit data output, bit[0] is LSB
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000;
        end else begin
            q <= d;
        end
    end

endmodule