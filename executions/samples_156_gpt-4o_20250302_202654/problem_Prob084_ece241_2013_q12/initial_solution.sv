module TopModule (
    input logic clk,
    input logic reset_n,
    input logic enable,
    input logic S,
    input logic [2:0] ABC,
    output logic Z
);

    logic [7:0] Q;

    // Shift Register with Asynchronous Reset
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            Q <= 8'b0;
        end else if (enable) begin
            Q <= {S, Q[7:1]};
        end
    end

    // Multiplexer Logic for Output Z
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
            default: Z = 1'b0; // Default case for safety
        endcase
    end

endmodule