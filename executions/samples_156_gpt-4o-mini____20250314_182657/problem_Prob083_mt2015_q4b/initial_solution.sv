module TopModule (
    input logic x,
    input logic y,
    output logic z
);

    logic state;

    always @(*) begin
        case (state)
            1'b0: z = (x == 1'b1 && y == 1'b1) ? 1'b1 : 1'b0;
            1'b1: z = (x == 1'b0 && y == 1'b0) ? 1'b1 : 1'b0;
            default: z = 1'b0;
        endcase
    end

    always @(posedge x or posedge y) begin
        if (x == 1'b1 && y == 1'b0) begin
            state <= 1'b1;
        end else if (x == 1'b0 && y == 1'b1) begin
            state <= 1'b0;
        end
    end

    initial begin
        state = 1'b0;
        z = 1'b1;
    end

endmodule