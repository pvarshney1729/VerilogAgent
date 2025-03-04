module TopModule(
    input logic clk,                // Clock signal, positive edge-triggered
    input logic load,               // Load control signal, active high
    input logic [9:0] data,         // 10-bit input data, unsigned (bit[9] is MSB, bit[0] is LSB)
    output logic tc                 // Terminal count output signal, active high
);

    logic [9:0] counter;            // Internal 10-bit counter

    // Initialize counter to zero
    initial begin
        counter = 10'b0;
        tc = 1'b0;
    end

    // Sequential logic for counter and terminal count
    always_ff @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc <= (data == 10'b0); // Assert tc if loaded data is zero
        end else if (counter != 10'b0) begin
            counter <= counter - 1;
            if (counter == 10'b1) begin
                tc <= 1'b1; // Assert tc when counter reaches zero
            end
        end
    end

endmodule