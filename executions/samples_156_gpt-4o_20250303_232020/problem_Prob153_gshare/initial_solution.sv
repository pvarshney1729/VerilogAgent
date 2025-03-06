module TopModule (
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

    // Parameters
    localparam PHT_SIZE = 128;
    localparam COUNTER_BITS = 2;
    localparam COUNTER_MAX = 2'b11;
    localparam COUNTER_MIN = 2'b00;
    localparam COUNTER_INIT = 2'b10;

    // Internal signals
    logic [COUNTER_BITS-1:0] PHT [0:PHT_SIZE-1];
    logic [6:0] global_history;
    logic [6:0] predict_index, train_index;
    logic [COUNTER_BITS-1:0] predict_counter, train_counter;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < PHT_SIZE; i++) begin
                PHT[i] <= COUNTER_INIT;
            end
        end else begin
            if (train_valid) begin
                train_index = train_pc ^ train_history;
                train_counter = PHT[train_index];
                if (train_taken && train_counter < COUNTER_MAX) begin
                    PHT[train_index] <= train_counter + 1;
                end else if (!train_taken && train_counter > COUNTER_MIN) begin
                    PHT[train_index] <= train_counter - 1;
                end
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

    // Prediction logic
    always_comb begin
        predict_index = predict_pc ^ global_history;
        predict_counter = PHT[predict_index];
        predict_taken = predict_counter[1];
        predict_history = global_history;
    end

endmodule