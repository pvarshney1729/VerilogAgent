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

    // Parameters
    localparam PHT_SIZE = 128;
    localparam PHT_WIDTH = 2;
    
    // State Variables
    logic [6:0] global_history; // Global Branch History Register
    logic [PHT_SIZE-1:0][PHT_WIDTH-1:0] PHT; // Pattern History Table (PHT)

    // Index calculation for PHT
    logic [6:0] index;
    assign index = (predict_pc ^ global_history) % PHT_SIZE;

    // Prediction output
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0; // Reset global history
            // Initialize PHT entries to 00
            for (int i = 0; i < PHT_SIZE; i++) begin
                PHT[i] <= 2'b00; // Initialize counter to 00
            end
        end else begin
            // Handle prediction
            if (predict_valid) begin
                predict_taken <= (PHT[index] >= 2'b10); // Taken if counter is 10 or 11
                predict_history <= global_history; // Output current global history
                // Update global history based on prediction
                global_history <= {global_history[5:0], predict_taken};
            end
            
            // Handle training
            if (train_valid) begin
                // Update PHT
                if (train_taken && PHT[index] < 2'b11) begin
                    PHT[index] <= PHT[index] + 1; // Increment if taken
                end else if (!train_taken && PHT[index] > 2'b00) begin
                    PHT[index] <= PHT[index] - 1; // Decrement if not taken
                end
                
                // Handle misprediction
                if (train_mispredicted) begin
                    global_history <= train_history; // Restore history to the given state
                end else begin
                    global_history <= {global_history[5:0], train_taken}; // Update history
                end
            end
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly