module TopModule (
    input logic x,
    input logic y,
    output logic z
);

    logic state;

    always @(*) begin
        case (state)
            1'b0: z = (x & y) ? 1'b1 : 1'b1; // states when x=0, y=0
            1'b1: z = (x & y) ? 1'b1 : 1'b0; // states when x=1, y=1
            default: z = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= 1'b0; // synchronous reset
        end else begin
            // state transitions based on x and y
            if (x && !y) state <= 1'b1;
            else if (!x && y) state <= 1'b0;
            else if (x && y) state <= 1'b1;
            else state <= state; // hold state
        end
    end

endmodule