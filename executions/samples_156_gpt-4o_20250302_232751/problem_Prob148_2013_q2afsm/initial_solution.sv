module TopModule (
    input  wire clk,             // Clock signal
    input  wire resetn,          // Active-low synchronous reset
    input  wire [2:0] r,         // Request signals (r[0]: high priority, r[2]: low priority)
    output reg  [2:0] g          // Grant signals (g[0]: high priority, g[2]: low priority)
);

    reg [1:0] state, next_state;

    // State encoding
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // State register
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (r[0])        next_state = B;
                else if (r[1])   next_state = C;
                else if (r[2])   next_state = D;
                else             next_state = A;
            end
            B: begin
                if (r[0])        next_state = B;
                else             next_state = A;
            end
            C: begin
                if (r[1])        next_state = C;
                else             next_state = A;
            end
            D: begin
                if (r[2])        next_state = D;
                else             next_state = A;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default output
        case (state)
            B: g[0] = 1;
            C: g[1] = 1;
            D: g[2] = 1;
        endcase
    end

endmodule