module TopModule (
    input logic clk,              // Clock signal, positive-edge triggered
    input logic areset,           // Asynchronous active-high reset

    input logic predict_valid,    // Prediction request valid signal
    input logic [6:0] predict_pc, // 7-bit Program Counter for prediction, unsigned
    output logic predict_taken,   // Output prediction result (1 bit)
    output logic [6:0] predict_history, // Current 7-bit Global History Register value, unsigned

    input logic train_valid,      // Training request valid signal
    input logic train_taken,      // Actual branch outcome (1 bit)
    input logic train_mispredicted, // Misprediction flag (1 bit)
    input logic [6:0] train_history, // 7-bit history value used in training, unsigned
    input logic [6:0] train_pc    // 7-bit Program Counter for training, unsigned
);

    logic [6:0] GHR; // Global History Register
    logic [1:0] PHT [0:127]; // Pattern History Table with 128 entries of 2-bit counters

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b0;
            end
        end else begin
            if (train_valid) begin
                // Training logic
                logic [6:0] train_index = train_pc ^ GHR;
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                if (train_mispredicted) begin
                    GHR <= train_history;
                end else begin
                    GHR <= {GHR[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Prediction logic
                logic [6:0] predict_index = predict_pc ^ GHR;
                predict_taken <= PHT[predict_index][1];
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end

    // Output current GHR
    assign predict_history = GHR;

endmodule