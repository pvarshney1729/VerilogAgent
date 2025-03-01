module TopModule (
    input logic clk,             // Clock signal, positive-edge triggered
    input logic areset,          // Asynchronous reset signal, active-high
    input logic predict_valid,   // Indicates a valid prediction, 1-bit
    input logic predict_taken,   // Prediction result to be shifted into history, 1-bit
    input logic train_mispredicted, // Indicates a misprediction condition, 1-bit
    input logic train_taken,     // Actual result of the branch post-misprediction, 1-bit
    input logic [31:0] train_history, // 32-bit history prior to mispredicted branch, unsigned
    output logic [31:0] predict_history // 32-bit current branch history, unsigned
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'b0;
        end else if (train_mispredicted) begin
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end

endmodule