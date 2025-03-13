[BEGIN]
module TopModule (
    input logic clk,                     // Clock input
    input logic areset,                  // Asynchronous reset, active high

    // Prediction Interface
    input logic predict_valid,           // Valid signal for prediction request
    input logic [6:0] predict_pc,        // 7-bit program counter for prediction
    output logic predict_taken,           // Predicted branch direction
    output logic [6:0] predict_history,   // Branch history register state used for prediction

    // Training Interface
    input logic train_valid,             // Valid signal for training request
    input logic train_taken,             // Actual branch outcome
    input logic train_mispredicted,      // Indicates if the branch was mispredicted
    input logic [6:0] train_history,     // 7-bit branch history used during prediction
    input logic [6:0] train_pc           // 7-bit program counter for training
);

    // Declare the global branch history register and initialize it
    logic [6:0] gbhr;

    // Declare the pattern history table (PHT) with 128 entries of 2-bit counters
    logic [1:0] pht [0:127];

    // Index calculation using XOR of pc and gbhr
    logic [6:0] predict_index;
    logic [6:0] train_index;

    // Asynchronous reset logic and PHT initialization
    integer i;
    always_ff @(posedge clk) begin
        if (areset) begin
            gbhr <= 7'b0000000;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b10; // Initialize to weakly taken
            end
        end else begin
            if (train_valid) begin
                // Calculate index using XOR of train_pc and train_history
                train_index = train_pc ^ train_history;

                // Update the PHT entry based on actual outcome
                if (train_taken) begin
                    if (pht[train_index] != 2'b11) pht[train_index] <= pht[train_index] + 1;
                end else begin
                    if (pht[train_index] != 2'b00) pht[train_index] <= pht[train_index] - 1;
                end

                // Recover gbhr if mispredicted
                if (train_mispredicted) begin
                    gbhr <= train_history;
                end
            end

            if (predict_valid) begin
                // Update predict_index using XOR of predict_pc and gbhr
                predict_index = predict_pc ^ gbhr;

                // Update predict_taken based on PHT value
                predict_taken <= (pht[predict_index] >= 2'b10);
                // Output current gbhr state
                predict_history <= gbhr;
                // Update global branch history register
                gbhr <= {gbhr[5:0], predict_taken};
            end
        end
    end
endmodule
[DONE]