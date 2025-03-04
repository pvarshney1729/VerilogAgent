module TopModule (
    input logic clk,                // Clock signal, positive edge-triggered
    input logic areset,             // Asynchronous reset, active high
    input logic predict_valid,      // Indicates a valid prediction cycle
    input logic predict_taken,      // Prediction outcome to shift into history
    input logic train_mispredicted, // Indicates a misprediction event
    input logic train_taken,        // Actual outcome of the branch
    input logic [31:0] train_history, // Historical branch outcomes before misprediction
    output logic [31:0] predict_history // Current state of the branch history
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                predict_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

endmodule