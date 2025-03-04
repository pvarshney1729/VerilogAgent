module TopModule (
    input logic clk,                  // Clock input
    input logic areset,               // Asynchronous reset, active high

    input logic predict_valid,        // Prediction request signal
    input logic [6:0] predict_pc,     // 7-bit program counter for prediction
    output logic predict_taken,       // Predicted branch direction
    output logic [6:0] predict_history, // 7-bit branch history used for prediction

    input logic train_valid,          // Training request signal
    input logic train_taken,          // Actual branch outcome
    input logic train_mispredicted,   // Misprediction indicator
    input logic [6:0] train_history,  // 7-bit branch history for training
    input logic [6:0] train_pc        // 7-bit program counter for training
);

    logic [6:0] global_history;
    logic [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters

    // Initialize PHT and global history
    initial begin
        global_history = 7'b0;
        for (int i = 0; i < 128; i++) begin
            PHT[i] = 2'b01; // Weakly not taken
        end
    end

    // Predict logic
    always @(*) begin
        if (predict_valid) begin
            logic [6:0] index;
            index = predict_pc ^ global_history;
            predict_taken = PHT[index][1]; // Most significant bit
            predict_history = global_history;
        end
    end

    // Sequential logic for updating history and PHT
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                logic [6:0] train_index;
                train_index = train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule