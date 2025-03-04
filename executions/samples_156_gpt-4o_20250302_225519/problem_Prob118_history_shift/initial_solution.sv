module TopModule (
    input logic clk,               // Clock signal, positive edge-triggered
    input logic areset,            // Asynchronous reset, active high
    input logic predict_valid,     // Signal indicating a prediction is valid
    input logic predict_taken,     // Signal indicating the prediction outcome
    input logic train_mispredicted,// Signal indicating a branch misprediction
    input logic train_taken,       // Actual outcome of the branch
    input logic [31:0] train_history, // History before the mispredicted branch
    output logic [31:0] predict_history // Current global history shift register
);

    // Reset and update logic for predict_history
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'b0; // Reset predict_history to all zeros
        end else if (train_mispredicted) begin
            predict_history <= {train_history[30:0], train_taken}; // Rollback on misprediction
        end else if (predict_valid) begin
            predict_history <= {predict_history[30:0], predict_taken}; // Update on valid prediction
        end
    end

endmodule