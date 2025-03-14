module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);
    logic [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with data
            tc <= 0;        // Reset tc when loading new value
        end else if (counter > 0) begin
            counter <= counter - 1; // Decrement the counter
            tc <= 0;                // tc remains low while counting
        end
        if (counter == 0) begin
            tc <= 1; // Assert tc when counter reaches 0
        end
    end
endmodule