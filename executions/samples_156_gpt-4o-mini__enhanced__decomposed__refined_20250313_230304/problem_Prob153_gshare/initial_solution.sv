[BEGIN]
module TopModule (
    input logic clk,                // Clock signal
    input logic areset,            // Asynchronous active-high reset
    input logic predict_valid,      // Indicates a valid prediction request
    input logic [6:0] predict_pc,   // 7-bit program counter for prediction (LSB at bit[0])
    output logic predict_taken,       // Output for predicted branch direction (1 = taken, 0 = not taken)
    output logic [6:0] predict_history,// 7-bit output for the state of the branch history register

    input logic train_valid,        // Indicates a valid training request
    input logic train_taken,        // Actual branch outcome for training (1 = taken, 0 = not taken)
    input logic train_mispredicted, // Indicates if the branch was mispredicted (1 = yes, 0 = no)
    input logic [6:0] train_history, // 7-bit global history for training (LSB at bit[0])
    input logic [6:0] train_pc      // 7-bit program counter for training (LSB at bit[0])
);

    logic [6:0] global_history;      // 7-bit global history register
    logic [1:0] PHT [127:0];         // 128-entry Pattern History Table (PHT)
    logic [6:0] index;               // Index for accessing the PHT

    // Compute index for PHT
    assign index = (predict_pc ^ global_history);

    always @(posedge clk) begin
        if (areset) begin
            predict_history <= 7'b0000000; // Reset predict history
            global_history <= 7'b0000000;  // Reset global history
            // Initialize PHT to a predetermined state (e.g., 2'b00)
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00;
            end
        end else begin
            // Training logic
            if (train_valid) begin
                if (train_mispredicted) begin
                    global_history <= train_history; // Restore history on misprediction
                end else begin
                    global_history <= {global_history[5:0], train_taken}; // Update history
                end

                // Update PHT based on training outcome
                if (train_taken) begin
                    if (PHT[index] < 2'b11) PHT[index] <= PHT[index] + 1; // Increment
                end else begin
                    if (PHT[index] > 2'b00) PHT[index] <= PHT[index] - 1; // Decrement
                end
            end
            
            // Prediction logic
            if (predict_valid) begin
                predict_taken <= (PHT[index] >= 2'b10); // Predict taken if counter is 2'b10 or higher
                // Update global history with the predicted branch
                global_history <= {global_history[5:0], predict_taken}; // Shift in the prediction
            end
        end
    end
endmodule
[DONE]