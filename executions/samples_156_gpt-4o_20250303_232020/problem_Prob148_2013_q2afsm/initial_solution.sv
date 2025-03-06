module TopModule (
    input logic clk,         // Clock input
    input logic resetn,      // Active-low synchronous reset
    input logic [2:0] r,     // Request inputs (r[0] for device 0, r[1] for device 1, r[2] for device 2)
    output logic [2:0] g     // Grant outputs (g[0] for device 0, g[1] for device 1, g[2] for device 2)
);

    logic [1:0] state, next_state;

    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // State register update
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (r[0]) next_state = B;
                else if (r[1]) next_state = C;
                else if (r[2]) next_state = D;
                else next_state = A;
            end
            B: begin
                if (!r[0]) next_state = A;
                else next_state = B;
            end
            C: begin
                if (!r[1]) next_state = A;
                else next_state = C;
            end
            D: begin
                if (!r[2]) next_state = A;
                else next_state = D;
            end
            default: next_state = A;
        endcase
    end

    // Grant outputs
    always @(*) begin
        g = 3'b000;
        case (state)
            B: g[0] = 1;
            C: g[1] = 1;
            D: g[2] = 1;
        endcase
    end

endmodule