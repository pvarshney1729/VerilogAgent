module TopModule (
    input  logic clock,
    input  logic a,
    output logic p,
    output logic q
);

    logic state;
    logic next_state;

    always @(posedge clock) begin
        state <= next_state;
    end

    always @(*) begin
        next_state = state; // Default to hold state
        p = 0; // Default output
        q = 0; // Default output

        case (state)
            1'b0: begin
                if (a) begin
                    next_state = 1'b1;
                end
            end
            1'b1: begin
                if (a) begin
                    p = 1;
                end else begin
                    q = 1;
                    next_state = 1'b0;
                end
            end
        endcase
    end

    initial begin
        state = 1'b0; // Initialize state to 0
        p = 0; // Initialize output p to 0
        q = 0; // Initialize output q to 0
    end

endmodule