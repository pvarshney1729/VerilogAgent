```
[BEGIN]
module TopModule (
    input logic clk,               // Clock signal, positive edge-triggered
    input logic areset,            // Asynchronous reset, active high
    input logic predict_valid,     // Indicates a valid branch prediction
    input logic predict_taken,     // Prediction result (1 for taken, 0 for not taken)
    input logic train_mispredicted,// Indicates a branch misprediction
    input logic train_taken,       // Actual result of the branch (1 for taken, 0 for not taken)
    input logic [31:0] train_history, // 32-bit history before misprediction, unsigned
    output logic [31:0] predict_history // 32-bit branch history register, unsigned
);

always @(posedge clk) begin
    if (areset) begin
        predict_history <= 32'b0; // Reset predict_history to zero
    end else if (train_mispredicted) begin
        predict_history <= {train_history[30:0], train_taken}; // Load with train_history and train_taken
    end else if (predict_valid) begin
        predict_history <= {predict_history[30:0], predict_taken}; // Shift and insert predict_taken
    end
end

endmodule
[DONE]
```