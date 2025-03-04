module TopModule (
    input logic clk,                            // Clock signal
    input logic areset,                         // Asynchronous reset, active high
    input logic predict_valid,                  // Prediction request valid signal
    input logic [6:0] predict_pc,               // 7-bit program counter for prediction
    output logic predict_taken,                  // Predicted branch direction (1-bit)
    output logic [6:0] predict_history,          // Branch history register (7-bit)
    input logic train_valid,                    // Training request valid signal
    input logic train_taken,                    // Actual branch outcome (1-bit)
    input logic train_mispredicted,             // Indicator of branch misprediction (1-bit)
    input logic [6:0] train_history,            // Branch history value during training (7-bit)
    input logic [6:0] train_pc                  // 7-bit program counter for training
);

    logic [6:0] bhr;                            // Global Branch History Register
    logic [1:0] pht [127:0];                    // Pattern History Table (128 entries of 2-bit counters)
    logic [6:0] index;                          // Index for PHT

    // Initialize registers on reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            bhr <= 7'b0000000;                  // Reset BHR to 0
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;                // Initialize PHT counters to 01
            end
        end else begin
            if (train_valid) begin
                index <= train_pc ^ train_history; // Calculate index for training
                if (train_taken) begin
                    if (pht[index] < 2'b11) begin
                        pht[index] <= pht[index] + 1; // Increment counter
                    end
                end else begin
                    if (pht[index] > 2'b00) begin
                        pht[index] <= pht[index] - 1; // Decrement counter
                    end
                end
                if (train_mispredicted) begin
                    bhr <= train_history;           // Recover BHR on misprediction
                end
            end
            
            if (predict_valid) begin
                index <= predict_pc ^ bhr;       // Calculate index for prediction
                predict_taken <= (pht[index] == 2'b10 || pht[index] == 2'b11); // Determine prediction
                predict_history <= bhr;           // Update predict_history with current BHR
            end
        end
    end

endmodule