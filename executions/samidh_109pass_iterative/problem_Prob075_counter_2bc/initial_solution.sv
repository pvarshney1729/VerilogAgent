module TopModule (
    input wire clk,             // Clock input, triggers on positive edge
    input wire areset,          // Asynchronous reset, active high
    input wire train_valid,     // Training validity signal
    input wire train_taken,     // Training taken signal
    output reg [1:0] state      // 2-bit counter output
);

    // Initial state on power-up
    initial begin
        state = 2'b01;
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Asynchronous reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 1;
                end
            end else begin
                if (state > 2'b00) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule