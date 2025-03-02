module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_prev;

    always @(posedge clk) begin
        if (reset) begin
            pedge <= 8'b00000000;
            in_prev <= 8'b00000000;
        end else begin
            pedge <= (~in_prev & in);
            in_prev <= in;
        end
    end

endmodule