module TopModule (
    input logic clk,
    input logic areset,  // Asynchronous active-high reset
    input logic predict_valid,
    input logic [6:0] predict_pc,  // 7-bit unsigned program counter for prediction
    output logic predict_taken,  // Predicted branch direction
    output logic [6:0] predict_history,  // Branch history used for prediction
    input logic train_valid,
    input logic train_taken,  // Actual branch outcome
    input logic train_mispredicted,  // Indication of misprediction
    input logic [6:0] train_history,  // 7-bit branch history for training
    input logic [6:0] train_pc  // 7-bit unsigned program counter for training
);

    logic [1:0] PHT [0:127];  // 128-entry table of two-bit saturating counters
    logic [6:0] global_history;
    logic [6:0] predict_index;
    logic [6:0] train_index;

    // Asynchronous reset and initialization
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00;
            end
        end else begin
            if (train_valid) begin
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

    // Prediction logic
    always_comb begin
        predict_index = predict_pc ^ global_history;
        predict_taken = (PHT[predict_index] >= 2'b10);
        predict_history = global_history;
    end

endmodule