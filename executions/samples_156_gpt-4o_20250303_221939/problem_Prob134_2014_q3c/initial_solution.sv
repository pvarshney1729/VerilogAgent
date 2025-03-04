module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;

    always_ff @(posedge clk) begin
        case (y)
            3'b000: begin
                if (x == 1'b0)
                    next_state <= 3'b000;
                else
                    next_state <= 3'b001;
                z <= 1'b0;
            end
            3'b001: begin
                if (x == 1'b0)
                    next_state <= 3'b001;
                else
                    next_state <= 3'b100;
                z <= 1'b0;
            end
            3'b010: begin
                if (x == 1'b0)
                    next_state <= 3'b010;
                else
                    next_state <= 3'b001;
                z <= 1'b0;
            end
            3'b011: begin
                if (x == 1'b0)
                    next_state <= 3'b001;
                else
                    next_state <= 3'b010;
                z <= 1'b1;
            end
            3'b100: begin
                if (x == 1'b0)
                    next_state <= 3'b011;
                else
                    next_state <= 3'b100;
                z <= 1'b1;
            end
            default: begin
                next_state <= y;
                z <= 1'b0;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        Y0 <= next_state[0];
    end

endmodule