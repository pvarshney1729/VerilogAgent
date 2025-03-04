module TopModule (
    input  logic        clk,                // Clock signal, positive edge-triggered
    input  logic        areset,             // Asynchronous active-high reset
    input  logic        predict_valid,      // Valid signal for prediction request
    input  logic [6:0]  predict_pc,         // 7-bit program counter for prediction, unsigned, LSB is bit[0]
    output logic        predict_taken,      // Predicted branch direction
    output logic [6:0]  predict_history,    // Branch history used for the prediction, unsigned
    input  logic        train_valid,        // Valid signal for training request
    input  logic        train_taken,        // Actual branch outcome
    input  logic        train_mispredicted, // Indicates if the branch was mispredicted
    input  logic [6:0]  train_history,      // 7-bit branch history used during training, unsigned
    input  logic [6:0]  train_pc            // 7-bit program counter used during training, unsigned
);

    // 128-entry table of 2-bit saturating counters
    logic [1:0] saturating_counters [0:127];
    logic [6:0] global_history;
    logic [6:0] predict_index, train_index;

    // Initialize saturating counters and global history
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            saturating_counters[i] = 2'b10; // Weakly not taken
        end
        global_history = 7'b0000000;
    end

    // Calculate indices
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Predict operation
    always @(*) begin
        if (predict_valid) begin
            predict_taken = saturating_counters[predict_index][1];
            predict_history = global_history;
        end
    end

    // Sequential logic for training and updating global history
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0000000;
        end else begin
            if (train_valid) begin
                // Update saturating counter
                if (train_taken) begin
                    if (saturating_counters[train_index] != 2'b11) begin
                        saturating_counters[train_index] <= saturating_counters[train_index] + 1;
                    end
                end else begin
                    if (saturating_counters[train_index] != 2'b00) begin
                        saturating_counters[train_index] <= saturating_counters[train_index] - 1;
                    end
                end

                // Restore global history if mispredicted
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history if not training
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule