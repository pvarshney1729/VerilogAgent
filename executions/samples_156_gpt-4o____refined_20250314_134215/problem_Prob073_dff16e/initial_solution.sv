[BEGIN]
module TopModule (
    input  logic        clk,
    input  logic        resetn,
    input  logic [1:0]  byteena,
    input  logic [15:0] d,
    output logic [15:0] q
);

    always_ff @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0;
        end else begin
            if (byteena[1]) begin
                q[15:8] <= d[15:8];
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0];
            end
        end
    end

endmodule
[END]