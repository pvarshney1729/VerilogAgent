module TopModule (
    input logic clk, 
    input logic in, 
    output logic out
);

    logic xor_out;

    // XOR Gate Logic
    assign xor_out = in ^ out;

    // D Flip-Flop with Positive Edge Triggering
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

    // Simulation Initial Condition (optional)
    initial begin
        out = 1'b0; // Define initial state for simulation purposes
    end

endmodule