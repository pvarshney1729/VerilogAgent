module TopModule (
    input  logic          clk,             // Clock input
    input  logic          areset,          // Asynchronous reset, active high
    input  logic          predict_valid,   // Prediction request valid
    input  logic [6:0]    predict_pc,      // 7-bit program counter for prediction
    output logic          predict_taken,   // Prediction result: branch taken or not
    output logic [6:0]    predict_history, // Branch history used in prediction
    input  logic          train_valid,     // Training request valid
    input  logic          train_taken,     // Actual branch outcome for training
    input  logic          train_mispredicted, // Indicates if the branch was mispredicted
    input  logic [6:0]    train_history,   // Branch history for training
    input  logic [6:0]    train_pc         // 7-bit program counter for training
);

    logic [6:0] global_history;
    logic [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters

    // Initialize PHT and global_history on reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0000000;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Weakly not-taken state
            end
        end else begin
            if (train_valid) begin
                logic [6:0] train_index = train_pc ^ train_history;
                if (train_taken && PHT[train_index] != 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end else if (!train_taken && PHT[train_index] != 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

    // Prediction logic
    always_comb begin
        if (predict_valid) begin
            logic [6:0] predict_index = predict_pc ^ global_history;
            predict_taken = PHT[predict_index][1]; // MSB determines taken or not
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0000000;
        end
    end

endmodule