```verilog
module TopModule(
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    logic [1:0] state;

    parameter STATE_A = 2'b01;
    parameter STATE_B = 2'b10;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            case (state)
                STATE_A: begin
                    if (x) begin
                        state <= STATE_B;
                        z <= 1;
                    end else begin
                        z <= 0;
                    end
                end
                STATE_B: begin
                    if (x) begin
                        z <= 0;
                    end else begin
                        z <= 1;
                    end
                end
            endcase
        end
    end

endmodule
```