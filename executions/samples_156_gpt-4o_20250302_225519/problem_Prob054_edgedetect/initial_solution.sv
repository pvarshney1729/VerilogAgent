module TopModule (
    input logic clk,
    input logic reset_n,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_prev;

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            in_prev <= 8'b0;
            pedge <= 8'b0;
        end else begin
            pedge <= ~in_prev & in;
            in_prev <= in;
        end
    end

endmodule