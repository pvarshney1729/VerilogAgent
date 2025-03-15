module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);
    logic [1:0] state;

    always @(posedge clock) begin
        case (state)
            2'b00: begin
                p <= 1'b0;
                q <= 1'b0;
                if (a) state <= 2'b01;
            end
            2'b01: begin
                p <= 1'b0;
                q <= 1'b0;
                if (a) state <= 2'b10;
                else state <= 2'b00;
            end
            2'b10: begin
                p <= 1'b1;
                q <= 1'b0;
                if (a) state <= 2'b11;
                else state <= 2'b00;
            end
            2'b11: begin
                p <= 1'b1;
                q <= 1'b1;
                if (!a) state <= 2'b00;
            end
            default: state <= 2'b00;
        endcase
    end

    initial begin
        state = 2'b00;
        p = 1'b0;
        q = 1'b0;
    end
endmodule