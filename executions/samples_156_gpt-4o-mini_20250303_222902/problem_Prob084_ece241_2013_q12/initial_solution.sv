module TopModule (
    input logic clk,
    input logic enable,
    input logic S,
    input logic [2:0] A,
    input logic rst,
    output logic Z
);

    logic [7:0] Q;

    // Asynchronous reset
    always @(*) begin
        if (rst) begin
            Q = 8'b00000000;
        end
    end

    // Shift register logic
    always @(posedge clk) begin
        if (enable) begin
            Q[0] <= S;
            Q[7:1] <= Q[6:0];
        end
    end

    // Multiplexer for output Z
    always @(*) begin
        case (A)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case, though not needed for 3-bit input
        endcase
    end

endmodule