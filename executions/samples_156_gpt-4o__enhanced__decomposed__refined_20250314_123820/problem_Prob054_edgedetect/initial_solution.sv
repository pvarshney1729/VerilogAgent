[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] previous_in;

    always_ff @(posedge clk) begin
        integer i;
        for (i = 0; i < 8; i = i + 1) begin
            pedge[i] <= (previous_in[i] == 1'b0 && in[i] == 1'b1) ? 1'b1 : 1'b0;
        end
        previous_in <= in;
    end

endmodule
[DONE]