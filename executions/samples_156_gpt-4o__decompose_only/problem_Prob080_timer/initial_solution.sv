module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter; // 10-bit register for the internal counter

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with the input data
        end else if (counter != 10'b0) begin
            counter <= counter - 1; // Decrement the counter if it's not zero
        end
    end

    always @(*) begin
        tc = (counter == 10'b0); // Assert tc when the counter reaches zero
    end

endmodule