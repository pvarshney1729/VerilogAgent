module TopModule (
    input logic clk,        // Clock signal, 1 bit, positive edge triggered
    input logic load,       // Load signal, 1 bit, active high
    input logic reset,      // Synchronous reset signal
    input logic [9:0] data, // 10-bit unsigned data input for loading the counter
    output logic tc         // Terminal count output, 1 bit, active high
);

    logic [9:0] counter; // 10-bit counter

    always @(posedge clk) begin
        if (reset) begin
            counter <= 10'b0; // Reset counter to zero
            tc <= 1'b0; // Deassert tc on reset
        end else if (load) begin
            counter <= data; // Load data into counter
            tc <= (data == 10'b0) ? 1'b1 : 1'b0; // Assert tc if data is zero
        end else begin
            if (counter > 10'b0) begin
                counter <= counter - 1'b1; // Decrement counter
                tc <= 1'b0; // Deassert tc while counting down
            end else begin
                tc <= 1'b1; // Assert tc when counter reaches zero
            end
        end
    end

endmodule