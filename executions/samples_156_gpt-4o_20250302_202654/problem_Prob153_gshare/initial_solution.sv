module TopModule (
    input logic clk,                // Clock signal, positive edge-triggered.
    input logic areset,             // Asynchronous reset, active-high.

    // Prediction Interface
    input logic predict_valid,      // Valid signal for prediction request.
    input logic [6:0] predict_pc,   // 7-bit program counter for prediction.
    output logic predict_taken,     // Predicted branch direction (1 = taken, 0 = not taken).
    output logic [6:0] predict_history, // 7-bit history used for prediction.

    // Training Interface
    input logic train_valid,        // Valid signal for training request.
    input logic train_taken,        // Actual outcome of the branch (1 = taken, 0 = not taken).
    input logic train_mispredicted, // Indicator if the branch was mispredicted.
    input logic [6:0] train_history,// 7-bit history for training.
    input logic [6:0] train_pc      // 7-bit program counter for training.
);

    // Parameters
    localparam PHT_SIZE = 128; // Size of the Pattern History Table (2^7)
    localparam WEAKLY_TAKEN = 2'b01;

    // Registers
    logic [1:0] PHT [0:PHT_SIZE-1]; // Pattern History Table
    logic [6:0] global_history;     // Global branch history register

    // Initialize PHT and global history
    initial begin
        integer i;
        for (i = 0; i < PHT_SIZE; i = i + 1) begin
            PHT[i] = WEAKLY_TAKEN;
        end
        global_history = 7'b0;
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            logic [6:0] index;
            index = predict_pc ^ global_history;
            predict_taken = PHT[index][1]; // MSB of the counter
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Sequential logic for updating global history and PHT
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                logic [6:0] train_index;
                train_index = train_pc ^ train_history;
                // Update PHT based on train_taken
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
                // Restore global history if mispredicted
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end else if (predict_valid) begin
                // Update global history based on prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule