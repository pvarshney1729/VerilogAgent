module TopModule (
    input logic clk,
    input logic reset,
    input logic [1:0] branch_outcome, // 00: not taken, 01: taken, 10: not taken, 11: taken
    output logic prediction
);

    // Global History Register
    logic [3:0] global_history; // 4-bit history register

    // Pattern History Table (PHT)
    logic [1:0] PHT [0:15]; // 16 entries, 2 bits each for 2-bit saturating counters

    // Prediction logic
    logic [1:0] pht_index;
    logic [1:0] pht_value;

    // Initialize PHT and global history on reset
    always @(posedge clk) begin
        if (reset) begin
            global_history <= 4'b0000;
            for (int i = 0; i < 16; i++) begin
                PHT[i] <= 2'b00; // Initialize all entries to '00'
            end
        end else begin
            // Update prediction based on global history
            pht_index = global_history[3:0]; // Use lower bits of global history as index
            pht_value = PHT[pht_index]; // Read current PHT value

            // Prediction logic: if counter is 10 or 11, predict taken
            prediction = (pht_value[1] == 1'b1);

            // Update global history
            global_history = {global_history[2:0], branch_outcome[1]}; // Shift in the latest outcome

            // Training logic: update PHT based on actual outcome
            if (branch_outcome == 2'b01) begin // Taken
                if (pht_value != 2'b11) begin
                    PHT[pht_index] = pht_value + 2'b01; // Increment counter
                end
            end else if (branch_outcome == 2'b00) begin // Not taken
                if (pht_value != 2'b00) begin
                    PHT[pht_index] = pht_value - 2'b01; // Decrement counter
                end
            end
        end
    end

endmodule