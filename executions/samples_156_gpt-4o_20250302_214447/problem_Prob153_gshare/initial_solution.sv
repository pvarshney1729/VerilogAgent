module TopModule(
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic [6:0] predict_pc,
    input logic train_valid,
    input logic train_taken,
    input logic train_mispredicted,
    input logic [6:0] train_history,
    input logic [6:0] train_pc,
    output logic predict_taken,
    output logic [6:0] predict_history
);

    // 128-entry table of 2-bit saturating counters
    logic [1:0] pht [0:127];
    logic [6:0] global_history;
    logic [6:0] saved_history;

    // Initialize PHT and global history
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            pht[i] = 2'b01; // weakly not-taken
        end
        global_history = 7'b0000000;
    end

    // Predict logic
    always @(*) begin
        if (predict_valid) begin
            logic [6:0] index;
            index = predict_pc ^ global_history;
            predict_taken = pht[index][1]; // MSB of the counter
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0000000;
        end
    end

    // Training logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01; // weakly not-taken
            end
            global_history <= 7'b0000000;
        end else if (train_valid) begin
            logic [6:0] index;
            index = train_pc ^ train_history;
            if (!train_mispredicted) begin
                // Update the PHT
                if (train_taken) begin
                    if (pht[index] != 2'b11) pht[index] <= pht[index] + 1;
                end else begin
                    if (pht[index] != 2'b00) pht[index] <= pht[index] - 1;
                end
                // Update global history
                global_history <= {global_history[5:0], train_taken};
            end else begin
                // Restore history
                global_history <= saved_history;
            end
        end
    end

    // Save history after misprediction
    always_ff @(posedge clk) begin
        if (train_valid && train_mispredicted) begin
            saved_history <= global_history;
        end
    end

endmodule