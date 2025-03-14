```verilog
module TopModule (
    input logic clk,          // Clock input, positive edge-triggered
    input logic areset,       // Asynchronous reset input, active high
    input logic train_valid,  // Indicates valid training data
    input logic train_taken,  // Indicates training data was taken
    output logic [1:0] state  // 2-bit counter representing state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 2'b01; // Increment, saturate at 3
                end
            end else begin
                if (state > 2'b00) begin
                    state <= state - 2'b01; // Decrement, saturate at 0
                end
            end
        end
    end

endmodule
```