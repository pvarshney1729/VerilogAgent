module TopModule (
    input wire clk,
    input wire areset,
    input wire [7:0] d,
    output reg [7:0] q
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'h00;
        end else begin
            q <= d;
        end
    end

endmodule