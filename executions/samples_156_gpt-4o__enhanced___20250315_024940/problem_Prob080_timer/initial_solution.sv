module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter_reg; // 10-bit internal counter

    // Synchronous logic for counter operation
    always @(posedge clk) begin
        if (load) begin
            counter_reg <= data; // Load the counter with the data input
            tc <= 0; // Reset terminal count when loading new value
        end else if (counter_reg > 0) begin
            counter_reg <= counter_reg - 1; // Decrement the counter
        end
        
        // Set terminal count signal if counter reaches zero
        if (counter_reg == 0) begin
            tc <= 1; // Assert tc when counter reaches 0
        end
    end
    
    // Initialize counter and tc in simulation
    initial begin
        counter_reg = 10'b0; // Initialize counter to 0
        tc = 0;              // Initialize terminal count to 0
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly