```verilog
module my_module (
    input logic clk,
    input logic rst_n,
    input logic [1:0] sel,
    output logic byteena0,
    output logic byteena1
);

    always @(posedge clk) begin
        if (!rst_n) begin
            byteena0 <= 1'b0;
            byteena1 <= 1'b0;
        end else begin
            case (sel)
                2'b00: begin
                    byteena0 <= 1'b1;
                    byteena1 <= 1'b0;
                end
                2'b01: begin
                    byteena0 <= 1'b0;
                    byteena1 <= 1'b1;
                end
                2'b10: begin
                    byteena0 <= 1'b1;
                    byteena1 <= 1'b1;
                end
                2'b11: begin
                    byteena0 <= 1'b0;
                    byteena1 <= 1'b0;
                end
            endcase
        end
    end

endmodule
```