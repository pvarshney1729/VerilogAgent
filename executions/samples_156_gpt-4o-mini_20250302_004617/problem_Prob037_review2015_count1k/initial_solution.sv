module counter_10bit (
    input logic clk,
    input logic reset,
    output logic [9:0] count
);
    always @(*) begin
        if (reset) begin
            count = 10'b0000000000;
        end else begin
            count = (count == 10'd999) ? 10'b0000000000 : count + 10'b0000000001;
        end
    end
endmodule