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

    logic [1:0] PHT [127:0]; // Pattern History Table
    logic [6:0] global_history; // Global History Register
    logic [6:0] index; // Index for PHT
    logic [1:0] counter_state; // Current state of the counter
    logic [1:0] next_counter_state; // Next state of the counter

    // Calculate index for PHT
    assign index = (predict_pc ^ global_history) [6:0];

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            counter_state = PHT[index];
            predict_taken = (counter_state[1] == 1'b1);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Update logic for PHT and global history
    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00;
            end
        end else begin
            if (train_valid) begin
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover history on misprediction
                end else begin
                    global_history <= {global_history[5:0], train_taken}; // Update history
                end

                // Update PHT based on training outcome
                case (PHT[train_pc ^ global_history])
                    2'b00: PHT[train_pc ^ global_history] <= train_taken ? 2'b01 : 2'b00;
                    2'b01: PHT[train_pc ^ global_history] <= train_taken ? 2'b10 : 2'b00;
                    2'b10: PHT[train_pc ^ global_history] <= train_taken ? 2'b11 : 2'b01;
                    2'b11: PHT[train_pc ^ global_history] <= train_taken ? 2'b11 : 2'b10;
                endcase
            end else if (predict_valid) begin
                // Update global history with the predicted outcome
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule