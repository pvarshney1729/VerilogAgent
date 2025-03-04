module TopModule (
    input logic clk, // Clock signal, positive edge-triggered.
    input logic areset, // Asynchronous active-high reset.
    input logic predict_valid, // Prediction request valid signal.
    input logic [6:0] predict_pc, // 7-bit program counter for prediction.
    output logic predict_taken, // Predicted branch direction.
    output logic [6:0] predict_history, // 7-bit branch history used in prediction.
    input logic train_valid, // Training request valid signal.
    input logic train_taken, // Actual branch outcome.
    input logic train_mispredicted, // Misprediction indicator.
    input logic [6:0] train_history, // 7-bit branch history for training.
    input logic [6:0] train_pc // 7-bit program counter for training.
);

    logic [6:0] GHR; // Global History Register
    logic [1:0] PHT [0:127]; // Pattern History Table

    // Initialize PHT entries to weakly non-taken state (2'b01)
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01;
        end
    end

    // Asynchronous reset for GHR
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0000000;
        end else if (train_valid) begin
            if (train_mispredicted) begin
                GHR <= train_history;
            end else begin
                GHR <= {GHR[5:0], train_taken};
            end
        end else if (predict_valid) begin
            GHR <= {GHR[5:0], predict_taken};
        end
    end

    // Prediction process
    always_comb begin
        if (predict_valid) begin
            logic [6:0] predict_index;
            predict_index = predict_pc ^ GHR;
            predict_taken = PHT[predict_index][1];
            predict_history = GHR;
        end
    end

    // Training process
    always_ff @(posedge clk) begin
        if (train_valid) begin
            logic [6:0] train_index;
            train_index = train_pc ^ train_history;
            if (train_taken) begin
                if (PHT[train_index] < 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end else begin
                if (PHT[train_index] > 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end
        end
    end

endmodule