```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    logic [2:0] Y; // Next state register

    always_ff @(posedge clk) begin
        if (reset) begin
            Y <= 3'b000;
            z <= 1'b0;
        end else begin
            case (y)
                3'b000: Y <= (x == 1'b0) ? 3'b000 : 3'b001;
                3'b001: Y <= (x == 1'b0) ? 3'b001 : 3'b100;
                3'b010: Y <= (x == 1'b0) ? 3'b010 : 3'b001;
                3'b011: Y <= (x == 1'b0) ? 3'b001 : 3'b010;
                3'b100: Y <= (x == 1'b0) ? 3'b011 : 3'b100;
                default: Y <= 3'b000; // For safety, reset undefined states to 000
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            z <= 1'b0;
        end else begin
            case (y)
                3'b011, 3'b100: z <= 1'b1;
                default: z <= 1'b0;
            endcase
        end
    end

    always_comb begin
        Y0 = Y[0]; // Combinationally derived output
    end
endmodule
[DONE]
```