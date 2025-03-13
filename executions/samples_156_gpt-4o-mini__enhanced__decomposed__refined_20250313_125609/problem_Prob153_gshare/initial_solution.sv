[BEGIN]
module TopModule (
    input  logic clk,                   // Clock signal
    input  logic areset,                // Asynchronous active-high reset

    input  logic predict_valid,          // Prediction request valid signal
    input  logic [6:0] predict_pc,      // 7-bit program counter for prediction
    output logic predict_taken,          // Predicted taken signal (1 bit)
    output logic [6:0] predict_history,  // 7-bit history for prediction

    input  logic train_valid,            // Training request valid signal
    input  logic train_taken,            // Actual outcome of the branch (1 bit)
    input  logic train_mispredicted,     // Indicates if the branch was mispredicted (1 bit)
    input  logic [6:0] train_history,    // 7-bit history for training
    input  logic [6:0] train_pc          // 7-bit program counter for training
);

logic [6:0] global_history;               // 7-bit global branch history register
logic [1:0] PHT [0:127];                  // Pattern history table (128 entries of 2 bits)
logic [6:0] index;                        // Index for accessing the PHT

always_ff @(posedge clk) begin
    if (areset) begin
        global_history <= 7'b0000000;    // Initialize global history register to zero
        // Initialize all PHT entries to 2'b00 (strongly not taken)
        for (int i = 0; i < 128; i++) begin
            PHT[i] <= 2'b00;
        end
    end else begin
        if (train_valid) begin
            index = train_pc ^ global_history; // Compute index using XOR
            if (train_mispredicted) begin
                global_history <= train_history; // Restore history after mispredict
            end else begin
                global_history <= {global_history[5:0], train_taken}; // Shift in the new outcome
            end
            
            // Update the PHT based on the train_taken outcome
            case (PHT[index])
                2'b00: PHT[index] <= train_taken ? 2'b01 : 2'b00; // Strongly not taken
                2'b01: PHT[index] <= train_taken ? 2'b10 : 2'b00; // Weakly taken
                2'b10: PHT[index] <= train_taken ? 2'b11 : 2'b01; // Weakly not taken
                2'b11: PHT[index] <= train_taken ? 2'b11 : 2'b10; // Strongly taken
            endcase
        end
        
        if (predict_valid) begin
            index = predict_pc ^ global_history; // Compute index for prediction
            predict_taken <= (PHT[index] == 2'b10 || PHT[index] == 2'b11); // Determine prediction
            predict_history <= global_history; // Output the current history
            // Update global history for prediction
            global_history <= {global_history[5:0], predict_taken}; // Shift in the predicted outcome
        end
    end
end

endmodule
[DONE]