module TopModule(
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

    // 128-entry table of 2-bit saturating counters
    logic [1:0] PHT [0:127];
    // 7-bit global history register
    logic [6:0] global_history;

    // Initialize PHT and global history register
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b00;
        end
        global_history = 7'b0000000;
    end

    // Predict logic
    always @(*) begin
        if (predict_valid) begin
            logic [6:0] index = predict_pc ^ global_history;
            predict_taken = (PHT[index] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0000000;
        end
    end

    // Sequential logic for updating global history and PHT
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0000000;
        end else begin
            if (train_valid) begin
                logic [6:0] train_index = train_pc ^ train_history;
                // Update PHT based on actual outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
                // Update global history
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history for prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule