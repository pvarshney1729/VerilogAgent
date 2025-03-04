module TopModule (
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic [6:0] predict_pc,
    output logic predict_taken,
    output logic [6:0] predict_history,
    input logic train_valid,
    input logic train_taken,
    input logic train_mispredicted,
    input logic [6:0] train_history,
    input logic [6:0] train_pc
);

    // Pattern History Table (PHT) with 128 entries of 2-bit saturating counters
    logic [1:0] PHT [0:127];
    logic [6:0] branch_history;

    // Initialize PHT and branch history register
    initial begin
        branch_history = 7'b0000000;
        for (int i = 0; i < 128; i++) begin
            PHT[i] = 2'b01; // Weakly not-taken
        end
    end

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history <= 7'b0000000;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Weakly not-taken
            end
        end else begin
            if (predict_valid) begin
                // Update branch history register
                branch_history <= {branch_history[5:0], predict_taken};
            end
            if (train_valid) begin
                // Update PHT based on training
                logic [6:0] train_index = train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
            end
        end
    end

    // Prediction logic
    always_comb begin
        logic [6:0] predict_index = predict_pc ^ branch_history;
        predict_taken = (PHT[predict_index] >= 2'b10);
        predict_history = branch_history;
    end

endmodule