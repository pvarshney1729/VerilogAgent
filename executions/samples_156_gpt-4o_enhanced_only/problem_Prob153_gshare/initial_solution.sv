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

    // Constants
    localparam PHT_SIZE = 128;
    localparam PHT_BITS = 2;

    // Pattern History Table (PHT) - 128 entries, each 2 bits
    logic [PHT_BITS-1:0] PHT [0:PHT_SIZE-1];

    // Global Branch History Register
    logic [6:0] global_history;

    // Internal signals
    logic [6:0] predict_index;
    logic [6:0] train_index;

    // Compute PHT index by XOR-ing PC with history
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Output the current state of the global history
    assign predict_history = global_history;

    // Predict branch taken or not
    always_comb begin
        if (predict_valid) begin
            // Predict branch taken if counter's MSB is 1
            predict_taken = PHT[predict_index][1];
        end else begin
            predict_taken = 1'b0;
        end
    end

    // Update logic for PHT and global history register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            // Reset PHT to weakly taken (e.g., 2'b10)
            for (int i = 0; i < PHT_SIZE; i++) begin
                PHT[i] <= 2'b10;
            end
        end else begin
            // Update global history register
            if (train_valid && train_mispredicted) begin
                // Recover global history for mispredicted branch
                global_history <= {global_history[5:0], train_taken};
            end else if (predict_valid) begin
                // Update global history with prediction outcome
                global_history <= {global_history[5:0], predict_taken};
            end

            // Update PHT
            if (train_valid) begin
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
            end
        end
    end

endmodule