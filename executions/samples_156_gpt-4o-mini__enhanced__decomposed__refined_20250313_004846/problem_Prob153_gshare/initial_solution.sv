[BEGIN]
module TopModule (
    input  logic        clk,                // Clock signal (positive edge-triggered)
    input  logic        areset,             // Asynchronous reset signal (active-high)

    input  logic        predict_valid,      // Valid signal for prediction operation
    input  logic [6:0]  predict_pc,         // 7-bit program counter for prediction
    output logic        predict_taken,      // Predicted branch taken signal
    output logic [6:0]  predict_history,    // 7-bit branch history used for prediction

    input  logic        train_valid,        // Valid signal for training operation
    input  logic        train_taken,        // Actual outcome of the branch (taken/not taken)
    input  logic        train_mispredicted, // Indicates if the branch was mispredicted
    input  logic [6:0]  train_history,      // 7-bit branch history during training
    input  logic [6:0]  train_pc            // 7-bit program counter for training
);
    logic [6:0] global_history;
    logic [1:0] pht [0:127]; // 128-entry table of two-bit saturating counters

    // Combinational logic for prediction
    always_comb begin
        logic [6:0] predict_index = predict_pc ^ global_history;
        predict_history = global_history;
        predict_taken = predict_valid ? pht[predict_index][1] : 1'b0; // Default to 0 if not valid
    end

    // Sequential logic for updating the PHT and global history register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01; // Initialize to weakly taken state
            end
        end else begin
            if (train_valid) begin
                logic [6:0] train_index = train_pc ^ train_history;

                // Update PHT based on training outcome
                if (train_taken && pht[train_index] != 2'b11) begin
                    pht[train_index] <= pht[train_index] + 1;
                end else if (!train_taken && pht[train_index] != 2'b00) begin
                    pht[train_index] <= pht[train_index] - 1;
                end

                // Update global history based on training
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history based on prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
endmodule
[DONE]