module TopModule (
    input logic clk,             // Clock signal, positive edge-triggered
    input logic rst_n,           // Active-low asynchronous reset
    input logic x,               // Control input, 1 bit
    input logic [2:0] y,         // Current state input, 3 bits, unsigned
    output logic Y0,             // Output bit, next state y[0] (LSB of next state)
    output logic z               // Output z, 1 bit
);

    logic [2:0] next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= 3'b000; // Reset state
            Y0 <= 1'b0;
            z <= 1'b0;
        end else begin
            case (y)
                3'b000: next_state <= (x) ? 3'b001 : 3'b000;
                3'b001: next_state <= (x) ? 3'b100 : 3'b001;
                3'b010: next_state <= (x) ? 3'b001 : 3'b010;
                3'b011: next_state <= (x) ? 3'b010 : 3'b001;
                3'b100: next_state <= (x) ? 3'b100 : 3'b011;
                default: next_state <= 3'b000; // Safe default state
            endcase
            Y0 <= next_state[0];
            z <= (y == 3'b011) || (y == 3'b100);
        end
    end

endmodule