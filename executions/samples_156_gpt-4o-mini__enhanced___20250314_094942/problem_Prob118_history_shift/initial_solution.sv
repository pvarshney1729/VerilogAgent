module TopModule (
    input logic clk,                   // Clock input, 1 bit wide
    input logic areset,               // Asynchronous active-high reset, 1 bit wide
    input logic predict_valid,         // Signal indicating prediction validity, 1 bit wide
    input logic predict_taken,         // Prediction outcome, 1 bit wide
    input logic train_mispredicted,    // Signal indicating a misprediction, 1 bit wide
    input logic train_taken,           // Actual outcome of the mispredicted branch, 1 bit wide
    input logic [31:0] train_history,  // History to load in case of misprediction, 32 bits wide
    output logic [31:0] predict_history  // Current branch history, 32 bits wide
);

    // Initial state of the predict_history register
    initial begin
        predict_history = 32'b0; // Initialize to all zeros
    end

    always @(posedge clk) begin
        if (areset) begin
            predict_history <= 32'b0; // Reset state
        end else begin
            if (train_mispredicted) begin
                // Load with history before the misprediction
                predict_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                // Shift in the prediction outcome
                predict_history <= {predict_history[30:0], predict_taken};
            end
            // If neither signal is asserted, retain current state.
        end
    end

endmodule