[BEGIN]
module TopModule (
    input logic clk,            // Clock input, positive edge triggered
    input logic enable,         // Synchronous active-high enable signal for shifting
    input logic S,             // Shift input bit
    input logic [2:0] A,       // 3-bit input for selecting output
    output logic Z             // 1-bit output
);

    // Internal 8-bit shift register declaration
    logic [7:0] Q;              // 8-bit register to hold memory values
    
    // Initial state of the shift register
    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]}; // Shift left, MSB shifted in from S
        end
    end

    // Output selection based on A (0-7 for 3-bit input)
    always @(*) begin
        Z = Q[A]; // Z is Q[A]
    end

endmodule
[DONE]