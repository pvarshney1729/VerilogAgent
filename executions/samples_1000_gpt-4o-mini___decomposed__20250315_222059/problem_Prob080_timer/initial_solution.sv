module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);
    logic [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with the input data
            tc <= 0;        // Reset terminal count
        end else if (counter > 0) begin
            counter <= counter - 1; // Decrement the counter
        end
    end

    assign tc = (counter == 10'b0); // Assert tc when counter reaches 0

endmodule