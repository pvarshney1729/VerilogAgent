module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    logic state;
    logic next_state;

    always @(posedge clock) begin
        state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            1'b0: begin
                if (a) begin
                    next_state = 1'b1;
                end
            end
            1'b1: begin
                if (a) begin
                    p = 1'b1;
                    next_state = 1'b0;
                end else begin
                    p = 1'b0;
                end
            end
        endcase
    end

    assign q = state;

endmodule