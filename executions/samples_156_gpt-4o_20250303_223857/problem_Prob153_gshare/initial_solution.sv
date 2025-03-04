module TopModule (
    input logic clk,                   // Clock signal
    input logic areset,                // Asynchronous active-high reset
    input logic predict_valid,         // Prediction request valid
    input logic [6:0] predict_pc,      // 7-bit program counter for prediction
    output logic predict_taken,        // 1-bit prediction result
    output logic [6:0] predict_history, // 7-bit predicted global history
    input logic train_valid,           // Training request valid
    input logic train_taken,           // Actual outcome of the branch
    input logic train_mispredicted,    // Flag indicating misprediction
    input logic [6:0] train_history,   // 7-bit history for training
    input logic [6:0] train_pc         // 7-bit program counter for training
);

    // Pattern History Table (PHT) with 128 entries of 2-bit counters
    logic [1:0] PHT [0:127];

    // Internal signals
    logic [6:0] predict_index;
    logic [6:0] train_index;
    logic [1:0] predict_counter;
    logic [1:0] train_counter;

    // Asynchronous reset and initialization
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Weakly not-taken
            end
        end else begin
            if (train_valid) begin
                // Training logic
                train_index = train_pc ^ train_history;
                train_counter = PHT[train_index];
                if (train_taken) begin
                    if (train_counter != 2'b11) begin
                        PHT[train_index] <= train_counter + 1;
                    end
                end else begin
                    if (train_counter != 2'b00) begin
                        PHT[train_index] <= train_counter - 1;
                    end
                end
                if (train_mispredicted) begin
                    predict_history <= train_history;
                end
            end else if (predict_valid) begin
                // Prediction logic
                predict_index = predict_pc ^ predict_history;
                predict_counter = PHT[predict_index];
                predict_taken = predict_counter[1];
                predict_history <= {predict_history[5:0], predict_taken};
            end
        end
    end

endmodule