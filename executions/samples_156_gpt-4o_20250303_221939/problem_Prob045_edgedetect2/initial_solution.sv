module TopModule (
    input wire clk,
    input wire rst,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        if (rst) begin
            anyedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            anyedge <= (in ^ prev_in);
            prev_in <= in;
        end
    end

endmodule