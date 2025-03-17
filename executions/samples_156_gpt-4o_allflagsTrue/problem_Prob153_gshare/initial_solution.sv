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

    // 7-bit global branch history register
    logic [6:0] global_history;

    // 128-entry table of two-bit saturating counters
    logic [1:0] PHT [0:127];

    // Calculate indices for prediction and training
    logic [6:0] predict_index;
    logic [6:0] train_index;

    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Prediction logic
    assign predict_taken = PHT[predict_index][1];
    assign predict_history = global_history;

    // Sequential logic for updating global history and PHT
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            // Initialize PHT entries to weakly not taken (01)
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01;
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
                // Update global history if mispredicted
                if (train_mispredicted) begin
                    global_history <= train_history;
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