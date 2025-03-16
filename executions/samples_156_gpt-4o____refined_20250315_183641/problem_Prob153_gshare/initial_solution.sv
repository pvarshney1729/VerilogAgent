[BEGIN]
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

    // Define the PHT as a 128-entry array of 2-bit saturating counters
    logic [1:0] PHT [0:127];
    logic [6:0] global_history;

    // Initialize all flip-flops to zero in simulation
    initial begin
        global_history = 7'b0;
        for (int i = 0; i < 128; i++) begin
            PHT[i] = 2'b01; // Weakly not taken
        end
    end

    // Predict logic
    always @(*) begin
        if (predict_valid) begin
            logic [6:0] index = predict_pc ^ global_history;
            predict_taken = PHT[index][1]; // MSB of the counter
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                logic [6:0] train_index = train_pc ^ train_history;
                // Update the PHT based on the actual outcome
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 2'b01;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 2'b01;
                    end
                end
                // Recover global history if mispredicted
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], predict_taken};
                end
            end else if (predict_valid) begin
                // Update global history for predicted branch
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
[DONE]