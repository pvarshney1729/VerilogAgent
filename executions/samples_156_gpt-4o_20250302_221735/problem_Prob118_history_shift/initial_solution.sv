module TopModule (
    input  logic          clk,           // Positive edge-triggered clock signal
    input  logic          areset,        // Asynchronous reset, active-high, resets state to zero
    input  logic          predict_valid, // Indicates a valid branch prediction
    input  logic          predict_taken, // Indicates the predicted outcome of the branch
    input  logic          train_mispredicted, // Indicates a branch misprediction event
    input  logic          train_taken,   // Indicates the actual outcome of the mispredicted branch
    input  logic [31:0]   train_history, // The branch history prior to the mispredicted branch
    output logic [31:0]   predict_history // The current branch history
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