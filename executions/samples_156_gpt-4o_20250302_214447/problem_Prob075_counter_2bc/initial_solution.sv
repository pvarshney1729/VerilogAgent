```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && state != 2'b11) begin
                state <= state + 1;
            end else if (!train_taken && state != 2'b00) begin
                state <= state - 1;
            end
        end
    end

endmodule
```