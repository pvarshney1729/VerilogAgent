```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding
    logic state_A, state_B;

    // State transition and output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1'b1;
            state_B <= 1'b0;
            z <= 1'b0;
        end else begin
            if (state_A) begin
                if (x) begin
                    state_A <= 1'b0;
                    state_B <= 1'b1;
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
            end else if (state_B) begin
                if (x) begin
                    z <= 1'b0;
                end else begin
                    z <= 1'b1;
                end
            end
        end
    end

endmodule
```