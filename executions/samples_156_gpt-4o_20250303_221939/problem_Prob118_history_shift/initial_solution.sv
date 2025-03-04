module TopModule (
    input logic clk,                // Clock input, positive edge triggered
    input logic areset,             // Asynchronous reset, active high
    input logic predict_valid,      // Signal indicating a prediction is being made
    input logic predict_taken,      // Result of the prediction to be shifted into history
    input logic train_mispredicted, // Signal indicating a branch misprediction occurred
    input logic train_taken,        // Actual result of the mispredicted branch
    input logic [31:0] train_history, // History before the mispredicted branch
    output logic [31:0] predict_history // Current branch history
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                predict_history <= (train_history << 1) | train_taken;
            end else if (predict_valid) begin
                predict_history <= (predict_history << 1) | predict_taken;
            end
        end
    end

endmodule