module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y2,
    output logic Y3,
    output logic Y4
);

    // Output logic based on current state
    always @(*) begin
        case (y)
            6'b000001: begin
                Y1 = 1'b0;
                Y3 = 1'b1;
            end
            6'b000010: begin
                Y1 = 1'b1;
                Y3 = 1'b0;
            end
            6'b000100: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
            6'b001000: begin
                Y1 = 1'b1;
                Y3 = 1'b1;
            end
            6'b010000: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
            6'b100000: begin
                Y1 = 1'b1;
                Y3 = 1'b0;
            end
            default: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        endcase
    end

    // Next-state logic for Y2 and Y4
    always @(*) begin
        // Logic for Y2 (next state for y[1])
        Y2 = (y[0] & ~w) | (y[1] & ~w) | (y[5] & ~w);

        // Logic for Y4 (next state for y[3])
        Y4 = (y[1] & w) | (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w);
    end

endmodule