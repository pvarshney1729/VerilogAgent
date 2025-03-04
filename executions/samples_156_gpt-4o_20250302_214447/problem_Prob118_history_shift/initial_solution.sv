```verilog
module TopModule (
    input logic clk,                 // Clock signal, positive edge-triggered
    input logic areset,              // Asynchronous reset, active high
    input logic predict_valid,       // Indicates a branch prediction is made
    input logic predict_taken,       // Result of branch prediction, 1 bit
    input logic train_mispredicted,  // Indicates a branch misprediction occurred
    input logic train_taken,         // Actual outcome of the branch, 1 bit
    input logic [31:0] train_history,// Historical branch data, unsigned 32 bits
    output logic [31:0] predict_history // Branch history register, unsigned 32 bits
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                predict_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

endmodule
```