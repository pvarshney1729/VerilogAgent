module TopModule (
    input logic clk,                 // Clock signal (positive edge-triggered)
    input logic areset,              // Asynchronous reset (active high)
    input logic train_valid,         // Validity signal for training
    input logic train_taken,         // Indicates if training was taken
    output logic [1:0] state         // Two-bit counter state output
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Asynchronous reset to "weakly not-taken"
        end else if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) begin
                    state <= state + 1;
                end
            end else begin
                if (state != 2'b00) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule