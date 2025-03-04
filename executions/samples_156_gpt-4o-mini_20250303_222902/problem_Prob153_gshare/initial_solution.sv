module branch_predictor (
    logic clk,
    logic areset,
    logic predict_valid,
    logic [6:0] predict_pc,
    logic train_valid,
    logic train_taken,
    logic train_mispredicted,
    logic [6:0] train_history,
    logic [6:0] train_pc,
    logic predict_taken,
    logic [6:0] predict_history
);

    logic [6:0] global_history;
    logic [1:0] PHT [127:0];
    logic [6:0] index;

    // Asynchronous reset and initialization
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0000000;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Initialize PHT to weakly taken
            end
        end else begin
            if (train_valid) begin
                index <= train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[index] < 2'b11) begin
                        PHT[index] <= PHT[index] + 1;
                    end
                end else begin
                    if (PHT[index] > 2'b00) begin
                        PHT[index] <= PHT[index] - 1;
                    end
                end
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            index = predict_pc ^ global_history;
            predict_taken = PHT[index][1]; // MSB of the counter
            predict_history = global_history; // Update predict history
        end
    end

    // Update global history on clock edge
    always @(posedge clk) begin
        if (!train_valid) begin
            if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken}; // Shift in prediction
            end
        end
    end

endmodule