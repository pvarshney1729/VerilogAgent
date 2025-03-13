module TopModule (
    input logic clk,
    input logic resetn,
    input logic [1:0] byteena,
    input logic [15:0] d,
    output logic [15:0] q
);

    logic [15:0] ff;

    always @(posedge clk) begin
        if (!resetn) begin
            ff <= 16'b0;
        end else begin
            if (byteena[0]) begin
                ff[7:0] <= d[7:0];
            end
            if (byteena[1]) begin
                ff[15:8] <= d[15:8];
            end
        end
    end

    assign q = ff;

endmodule