module TopModule(
    input wire clk,
    input wire reset,
    output reg [3:0] count
);

always @(posedge clk) begin
    if (reset) begin
        count <= 4'b0001; // Reset to 1
    end else begin
        if (count == 4'b1010) begin
            count <= 4'b0001; // Wrap around to 1
        end else begin
            count <= count + 1'b1; // Increment counter
        end
    end
end

endmodule