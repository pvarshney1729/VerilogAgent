module TopModule (
    input  logic clk,           // Clock signal
    input  logic x,             // Input trigger
    input  logic [2:0] y,       // 3-bit input state
    output logic Y0,            // Output Y0 from the least significant bit of next state
    output logic z              // Output z
);

    logic [2:0] next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (y === 3'bx) begin
            next_state <= 3'b000; // Handle undefined states
        end else begin
            case (y)
                3'b000: next_state <= (x ? 3'b001 : 3'b000);
                3'b001: next_state <= (x ? 3'b100 : 3'b001);
                3'b010: next_state <= (x ? 3'b001 : 3'b010);
                3'b011: begin
                    next_state <= (x ? 3'b010 : 3'b001);
                    z <= 1;
                end
                3'b100: begin
                    next_state <= (x ? 3'b100 : 3'b011);
                    z <= 1;
                end
                default: next_state <= 3'b000; // Handle undefined states
            endcase
        end
    end

    // Output logic
    always @(*) begin
        Y0 = next_state[0];
        z = (y == 3'b011 || y == 3'b100) ? 1 : 0; // Update z based on current state
    end

endmodule