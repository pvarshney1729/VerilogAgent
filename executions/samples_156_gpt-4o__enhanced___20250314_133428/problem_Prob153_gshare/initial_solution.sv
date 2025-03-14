```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic [6:0] predict_pc,
    output logic predict_taken,
    output logic [6:0] predict_history,
    input logic train_valid,
    input logic train_taken,
    input logic train_mispredicted,
    input logic [6:0] train_history,
    input logic [6:0] train_pc
);

    // Global history register
    logic [6:0] global_history;

    // Pattern History Table (PHT) with 128 entries of 2-bit saturating counters
    logic [1:0] PHT [0:127];

    // Index for accessing PHT
    logic [6:0] predict_index, train_index;

    // Initialize PHT and global history register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0000000;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b10; // Weakly taken
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on training
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // Update global history register if mispredicted
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else if (predict_valid) begin
                    global_history <= {global_history[5:0], predict_taken};
                end
            end else if (predict_valid) begin
                // Update global history register after prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Calculate indices for prediction and training
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Prediction logic
    always_comb begin
        if (predict_valid) begin
            predict_taken = (PHT[predict_index] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0000000;
        end
    end

endmodule
```