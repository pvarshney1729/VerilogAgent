module TopModule (
    input logic clk,
    input logic rst,
    input logic [6:0] global_history,
    input logic branch_out,
    output logic prediction
);
    // Parameters
    localparam TABLE_SIZE = 128;
    localparam COUNTER_BITS = 2;

    // Saturating counter table
    logic [COUNTER_BITS-1:0] counter_table [0:TABLE_SIZE-1];
    
    // Global history register
    logic [6:0] gh_reg;

    // Prediction logic
    always @(*) begin
        prediction = counter_table[global_history[6:0]][1]; // Take the MSB for prediction
    end

    // Training logic
    always @(posedge clk) begin
        if (rst) begin
            // Reset all counters to zero
            for (int i = 0; i < TABLE_SIZE; i++) begin
                counter_table[i] <= 2'b00;
            end
            gh_reg <= 7'b0000000;
        end else begin
            // Update the global history register
            gh_reg <= {gh_reg[5:0], branch_out};

            // Update the saturating counter
            if (branch_out) begin
                if (counter_table[gh_reg[6:0]] < 2'b11) begin
                    counter_table[gh_reg[6:0]] <= counter_table[gh_reg[6:0]] + 1'b1;
                end
            end else begin
                if (counter_table[gh_reg[6:0]] > 2'b00) begin
                    counter_table[gh_reg[6:0]] <= counter_table[gh_reg[6:0]] - 1'b1;
                end
            end
        end
    end
endmodule