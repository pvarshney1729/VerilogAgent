module TopModule(
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    // Internal 10-bit register for the countdown counter
    logic [9:0] counter;

    // Sequential logic to update the counter and tc
    always_ff @(posedge clk) begin
        if (load) begin
            // Load the counter with the provided data
            counter <= data;
        end else if (counter != 10'b0) begin
            // Decrement counter if it's not zero
            counter <= counter - 1;
        end
    end

    // Combinational logic to set the tc output
    always_comb begin
        // tc is asserted when counter reaches 0
        tc = (counter == 10'b0);
    end

endmodule