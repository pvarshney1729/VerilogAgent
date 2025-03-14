module TopModule (
    input  logic clk,                     // Clock signal (1 bit)
    input  logic areset,                  // Asynchronous active-high reset (1 bit)
    
    input  logic predict_valid,            // Prediction request signal (1 bit)
    input  logic [6:0] predict_pc,        // 7-bit predicted program counter (PC)
    output logic predict_taken,            // Output for predicted branch taken (1 bit)
    output logic [6:0] predict_history,    // 7-bit predicted global history
    
    input  logic train_valid,              // Training request signal (1 bit)
    input  logic train_taken,              // Actual outcome of the branch (1 bit)
    input  logic train_mispredicted,       // Flag indicating misprediction (1 bit)
    input  logic [6:0] train_history,      // 7-bit actual branch history
    input  logic [6:0] train_pc            // 7-bit address of the branch being trained
);

    logic [6:0] global_history;            // 7-bit global history register
    logic [1:0] PHT [127:0];               // Pattern History Table (PHT) with 128 entries of 2-bit saturating counters
    logic [6:0] index;                     // Index for PHT access
    logic [1:0] current_state;             // Current state of the PHT entry for prediction

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;         // Reset global history
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00;           // Reset PHT entries
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on training information
                index <= train_pc ^ train_history; // Compute index using XOR
                if (train_taken) begin
                    if (PHT[index] < 2'b11) begin
                        PHT[index] <= PHT[index] + 1; // Increment if taken
                    end
                end else begin
                    if (PHT[index] > 2'b00) begin
                        PHT[index] <= PHT[index] - 1; // Decrement if not taken
                    end
                end
                // Update global history
                global_history <= {global_history[5:0], train_taken};
            end
            
            if (predict_valid) begin
                // Compute index for prediction
                index <= predict_pc ^ global_history; // Compute index using XOR
                current_state <= PHT[index]; // Read current state for prediction
                predict_taken <= (current_state[1] == 1'b1); // Predict taken if state is 2'b10 or 2'b11
                predict_history <= global_history; // Output current global history
            end
        end
    end
endmodule