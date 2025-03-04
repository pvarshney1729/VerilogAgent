module TopModule(
    input logic clk,               // Clock signal
    input logic areset,            // Asynchronous active-high reset

    input logic predict_valid,     // Validity flag for prediction
    input logic [6:0] predict_pc,  // 7-bit program counter for prediction
    output logic predict_taken,    // Output: Predicted branch direction
    output logic [6:0] predict_history, // Output: Branch history used for prediction

    input logic train_valid,       // Validity flag for training
    input logic train_taken,       // Actual branch outcome for training
    input logic train_mispredicted,// Misprediction indicator
    input logic [6:0] train_history, // Branch history for training
    input logic [6:0] train_pc     // 7-bit program counter for training
);

    logic [6:0] global_branch_history;
    logic [1:0] PHT [0:127]; // Pattern History Table with 2-bit counters

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_branch_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00;
            end
        end else begin
            if (train_valid) begin
                logic [6:0] train_index = train_pc ^ train_history;
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
                    global_branch_history <= train_history;
                end else begin
                    global_branch_history <= {global_branch_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                predict_history <= global_branch_history;
            end
        end
    end

    always_comb begin
        if (predict_valid) begin
            logic [6:0] predict_index = predict_pc ^ global_branch_history;
            predict_taken = PHT[predict_index][1];
        end else begin
            predict_taken = 1'b0;
        end
    end

endmodule