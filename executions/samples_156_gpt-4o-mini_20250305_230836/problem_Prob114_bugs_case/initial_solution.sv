```
[BEGIN]
module TopModule (
    input logic [7:0] code,
    input logic clk,
    input logic reset,
    output logic [3:0] detected_key,
    output logic valid
);

always @(posedge clk) begin
    if (reset) begin
        valid <= 1'b0;
        detected_key <= 4'b0000;
    end else begin
        case (code)
            8'h45: begin detected_key <= 4'b0000; valid <= 1'b1; end
            8'h16: begin detected_key <= 4'b0001; valid <= 1'b1; end
            8'h1e: begin detected_key <= 4'b0010; valid <= 1'b1; end
            8'h26: begin detected_key <= 4'b0011; valid <= 1'b1; end
            8'h25: begin detected_key <= 4'b0100; valid <= 1'b1; end
            8'h2e: begin detected_key <= 4'b0101; valid <= 1'b1; end
            8'h36: begin detected_key <= 4'b0110; valid <= 1'b1; end
            8'h3d: begin detected_key <= 4'b0111; valid <= 1'b1; end
            8'h3e: begin detected_key <= 4'b1000; valid <= 1'b1; end
            8'h46: begin detected_key <= 4'b1001; valid <= 1'b1; end
            default: begin detected_key <= 4'b0000; valid <= 1'b0; end
        endcase
    end
end

endmodule
[DONE]
```