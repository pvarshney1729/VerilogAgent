module TopModule (
    input wire clk,
    input wire L,
    input wire d0,
    input wire d1,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= d1;
        end else begin
            Q <= d0;
        end
    end

endmodule