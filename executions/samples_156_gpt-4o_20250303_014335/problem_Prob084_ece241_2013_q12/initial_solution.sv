module TopModule (
    input logic clk,             // Clock input, positive edge-triggered
    input logic enable,          // Synchronous active-high enable for shifting
    input logic S,               // Serial input for shift register
    input logic [2:0] ABC,       // 3-bit input for multiplexer selection
    output logic Z               // Output based on selected Q[n] value
);

    logic [7:0] Q; // 8-bit shift register

    // Shift register logic
    always_ff @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]};
        end
    end

    // Multiplexer logic for output Z
    always_comb begin
        case (ABC)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case to handle unexpected values
        endcase
    end

endmodule