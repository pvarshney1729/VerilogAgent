module TopModule (
    input logic clk,          // Clock input for synchronous operation
    input logic rst_n,        // Active-low asynchronous reset
    input logic x,            // Control input
    input logic [2:0] y,      // Present state input, 3 bits wide
    output logic Y0,           // Next state output bit 0, derived from Y[0]
    output logic z             // Output dependent on present state and input
);

    logic [2:0] next_state; // Next state variable

    always @(*) begin
        case (y)
            3'b000: begin
                next_state = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                next_state = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                next_state = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000; // Default to reset state on undefined states
                z = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (!rst_n) begin
            Y0 <= 1'b0;          // Ensure Y0 is consistent with reset state
            z <= 1'b0;           // Ensure z is consistent with reset state
        end else begin
            Y0 <= next_state[0]; // Output Y0 as the LSB of the next state
        end
    end

endmodule