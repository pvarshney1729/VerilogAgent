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
    logic [1:0] counter_state; // State of the counter for prediction
    logic training; // Flag for training operation
    logic [1:0] next_counter_state; // Next state for the counter

    // Asynchronous reset for global history
    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00; // Initialize PHT to 0
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on training
                index <= train_pc ^ train_history; // Compute index
                if (train_taken) begin
                    next_counter_state <= (PHT[index] == 2'b11) ? 2'b11 : PHT[index] + 1; // Increment
                end else begin
                    next_counter_state <= (PHT[index] == 2'b00) ? 2'b00 : PHT[index] - 1; // Decrement
                end
                PHT[index] <= next_counter_state; // Update PHT
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover history
                end
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            index = predict_pc ^ global_history; // Compute index
            counter_state = PHT[index]; // Read current state
            predict_taken = (counter_state[1] == 1'b1); // Predict taken if MSB is 1
            predict_history = global_history; // Output current history
        end else begin
            predict_taken = 1'b0; // Default output
            predict_history = 7'b0; // Default output
        end
    end

    // Update global history on prediction
    always @(posedge clk) begin
        if (!areset && predict_valid) begin
            global_history <= {global_history[5:0], predict_taken}; // Shift in the prediction
        end
    end

endmodule