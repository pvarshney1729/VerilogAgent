module TopModule (
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);
    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule