[BEGIN]
module TopModule (
    input logic clk,                    // Clock signal
    input logic areset,                 // Asynchronous active-high reset
    input logic predict_valid,          // Prediction request valid
    input logic [6:0] predict_pc,       // 7-bit program counter for prediction
    output logic predict_taken,         // Predicted branch direction
    output logic [6:0] predict_history, // 7-bit branch history used in prediction
    input logic train_valid,            // Training request valid
    input logic train_taken,            // Actual branch outcome for training
    input logic train_mispredicted,     // Indicates if the branch was mispredicted
    input logic [6:0] train_history,    // 7-bit branch history for training
    input logic [6:0] train_pc          // 7-bit program counter for training
);

    logic [6:0] global_history;         // Global branch history register
    logic [1:0] pht [0:127];            // Pattern History Table (PHT) with 128 2-bit counters

    // Synchronous Reset and Update
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b00;
            end
        end else begin
            if (train_valid) begin
                // Calculate index for training
                logic [6:0] train_index;
                train_index = train_pc ^ train_history;

                // Update PHT based on train_taken
                if (train_taken) begin
                    if (pht[train_index] < 2'b11) begin
                        pht[train_index] <= pht[train_index] + 2'b01;
                    end
                end else begin
                    if (pht[train_index] > 2'b00) begin
                        pht[train_index] <= pht[train_index] - 2'b01;
                    end
                end

                // Restore global history if mispredicted
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    // Update global history
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history on prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Combinational logic for prediction
    always_comb begin
        if (predict_valid) begin
            // Calculate index for prediction
            logic [6:0] predict_index;
            predict_index = predict_pc ^ global_history;

            // Output prediction result
            predict_taken = pht[predict_index][1];
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

endmodule
[DONE]